import re
import csv

class Issue():
	def __init__(self, doc):
		self.doc = doc

	def text(self):
		return self.doc

	def attribution(self,word):
		"""
		Searches a string for phrases that sound like they could be newspaper attributions.
		Returns the phrase.
		"""
		possibleAttr = [
		r"[Ff]rom [Tthlibe\?]+ ([\w\s\.]{0,7}" + word + ")",
		r"special to [Tthlibe\?]+ (\w*\.*\s*\w*\.{0,5}\s*" + word + ")",
		r"[Tthlibe\?]+ (\w*\.*\s*\w*\.*\s*" + word + ")\s\w*\s*says",
		r"[Bb]y [Tthlibe\?]+ last (\w*\.*\s*\w*\.*\s*" + word + ")",
		r"correspondent of [Tthlibe\?]+ (\w*\.*\s*\w*\.*\s*" + word + ")",
		r"(Associated" + word + ")",
		r"[Ii]n [Tthlibe\?]+ (\w*\.*\s*\w*\.*\s*(?<!of\s)" + word + ")",
		r"[Tthlibe\?]+ (\w*\.*\s*\w*\.*\s*" + word + ")\s\w*\s*remarks",
		r"[Tthlibe\?]+ (\w*\.*\s*\w*\.*\s*" + word + ")\sof the",
		r"[Tthlibe\?]+ (\w*\.*\s*\w*\.*\s*" + word + ")\sgives [Tthlibe\?]+ follow.*ing",
		]

		for attr in possibleAttr:
			attribution = re.search("|".join(possibleAttr),self.doc)
			if attribution:
				return attribution
			return ""



	def date(self):
		"""Pulls date out of the metadata already provided in document"""
		match = re.search(r"<date>(.*)</date>",self.doc)
		if match:
			return match.group(1)



def issueyielder(filename):
	"""
	Splits big doc into little docs so that each doc can be its own unit.
	"""
	text = open(filename, "r")
	a = text.readlines()
	p = "".join(a)

	docbreaks = p.split("<doc>")
	for doc in docbreaks:
		yield doc
	
def cleanup(attribution):
	"""
	Takes a string and cleans out (hopefully) everything but the actual name of the paper.
	"""
	capped = re.findall(r'[A-Z][a-z]+',attribution)
	cap_string = ' '.join(capped)
	name_only = re.sub(r"By ","",cap_string)
	name_only = re.sub(r"From ","",name_only)
	name_only = re.sub(r"T[hbilnat][eiolab]+ ","",name_only)
	name_only = re.sub(r"In ","",name_only)
	name_only = re.sub(r"This","",name_only)
	return name_only

def paper_replace(line):
	"""
	Takes a raw OCR string and normalizes paper titles. Need to re-factor this to be in a dict.
	"""
	if re.search(r"Ob[si]erver",line):
		return re.sub(r"Ob[si]erver","Observer",line)
	if re.search(r"Po[stre]t",line):
		return re.sub(r"Po[stre]t","Post",line)
	if re.search(r"[BKE]xpre[st]+",line):
		return re.sub(r"[BKE]xpre[st]+","Express",line)
	if re.search(r"D[de]moc[rk]at",line):
		return re.sub(r"D[de]moc[rk]at","Democrat",line)
	if re.search(r"New[ts]",line):
		return re.sub(r"New[ts]","News",line)
	if re.search(r"Ti[mest]*",line):
		return re.sub(r"Ti[mest]*","Times",line)
	if re.search(r"Pr[esut]+",line):
		return re.sub(r"Pr[esut]+","Press",line)
	if re.search(r"Baal St",line):
		return re.sub(r"Baal St","Herald",line)
	if re.search(r"Jo[un]rnal",line):
		return re.sub(r"Jo[un]rnal","Journal",line)
	if re.search(r"Mo[nu]iteur",line):
		return re.sub(r"Mo[nu]iteur","Moniteur",line)
	if re.search(r"Rep[un]bli[co]",line):
		return re.sub(r"Rep[un]bli[co]","Republic",line)
	if re.search(r"[KE][zx]amin[et]r",line):
		return re.sub(r"[KE][zx]amin[et]r","Examiner",line)
	if re.search(r"Fran[rc]e",line):
		return re.sub(r"Fran[rc]e","France",line)
	if re.search(r"C[oi]m+er[cia]al",line):
		return re.sub(r"C[oi]m+er[cia]al","Commercial",line)
	if re.search(r"Bote[co][bh]afler",line):
		return re.sub(r"Bote[co][bh]afler","Botechafler",line)
	if re.search(r"Observe[er]*",line):
		return re.sub(r"Observe[er]*","Observer",line)
	if re.search(r"Bull[ce]ti[nu]",line):
		return re.sub(r"Bull[ce]ti[nu]","Bulletin",line)
	if re.search(r"M[et]rcury",line):
		return re.sub(r"M[et]rcury","Mercury",line)
	if re.search(r"Su[rn]",line):
		return re.sub(r"Su[rn]","Sun",line)
	if re.search(r"[RIt]+egi[xlst]+er",line):
		return re.sub(r"[RIt]+egi[xlst]+er","Register",line)
	if re.search(r"Jtxuhiincr",line):
		return re.sub(r'Jtxuhiincr',"Examiner",line)
	return line

def place_cleaner(dict, line):
	"""
	Creates a regex searcher using a dict structure;
	takes a string and returns a clean place name.
	Copied from http://stackoverflow.com/questions/15175142/how-can-i-do-multiple-substitutions-using-regex-in-python"""
	regex = re.compile("(%s)" % "|".join(map(re.escape, dict.keys())))
	if regex: 
  # For each match, look-up corresponding value in dictionary
 		return regex.sub(lambda mo: dict[mo.string[mo.start():mo.end()]], line) 
 	return line

def dict_reader(file):
	'''
	Basic idea of this function from 
	https://www.daniweb.com/software-development/python/threads/239646/python-using-a-text-file-to-feed-into-a-python-dictionary'
	Major difficulty is that regex variables like [] don't seem to work, 
	so each individual bad OCR gets its own dict entry.
	'''
	place_dict = {}

	for line in open(file):
		line = line.rstrip('\n')
		key, val = line.split(':')
		place_dict[key] = val

	return place_dict

if __name__=="__main__":
	name_list = [line.strip() for line in open('attributions_names_WDI.csv')]
	attr_list = open("WDI_attr_2015-03-29.txt", "a")
	place_names_dict = dict_reader("WDI_places.txt")

	for issue in issueyielder('edit_batch_wvu_austria_ver01.pbd.metatext'):
		paper = Issue(issue)
		date = paper.date()
		
		for term in name_list:
			attr = paper.attribution(term)
			if attr != "":
				attr = attr.group()
				attr = re.sub('\n',' ',attr)
				clean = cleanup(attr)
				cleaner = paper_replace(clean)
				cleanest = place_cleaner(place_names_dict, cleaner)
				
				attr_list.write(print date + '\t' + attr + '\t' + cleaner + '\t' + cleanest + '\n')
				
			

	attr_list.close()