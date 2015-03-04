import re

class Issue():
	def __init__(self, doc):
		self.doc = doc

	def attribution(self,word):
		match = re.search(r"[Ff]rom [Tthlibe\?]+ ([\w\s\.]*" + word + ")", self.doc)
		if match:
			return match.group()
		match = re.search(r"[Tthlibe\?]+ (\w*\.*\s*\w*\.*\s*" + word + ")\s\w*\s*says", self.doc)
		if match:
			return match.group()
		match = re.search(r"special to [Tthlibe\?]+ (\w*\.*\s*\w*\.*\s*" + word + ")", self.doc)
		if match:
	 		return match.group()
	 	match = re.search(r"[Bb]y [Tthlibe\?]+ last (\w*\.*\s*\w*\.*\s*" + word + ")", self.doc)
	 	if match: 
	 		return match.group()
	 	match = re.search(r"correspondent of [Tthlibe\?]+ (\w*\.*\s*\w*\.*\s*" + word + ")", self.doc)
	 	if match: 
	 		return match.group()
	 	match = re.search(r"(Associated" + word + ")",self.doc)
	 	if match:
	 		return match.group()
	 	match = re.search(r"[Ii]n [Tthlibe\?]+ (\w*\.*\s*\w*\.*\s*" + word + ")", self.doc)
	 	if match:
	 		return match.group()
	 	match = re.search(r"[Tthlibe\?]+ (\w*\.*\s*\w*\.*\s*" + word + ")\s\w*\s*remarks", self.doc)
		if match:
			return match.group()
		match = re.search(r"[Tthlibe\?]+ (\w*\.*\s*\w*\.*\s*" + word + ")\sof the", self.doc)
		if match:
			return match.group()
		match = re.search(r"[Tthlibe\?]+ (\w*\.*\s*\w*\.*\s*" + word + ")\sgives [Tthlibe\?]+ follow.*ing", self.doc)
		if match:
			return match.group()
		return ""

	def date(self):
		match = re.search(r"<date>(.*)</date>",self.doc)
		if match:
			return match.group(1)


def issueyielder(filename,attr_list):
	text = open(filename, "r")
	a = text.readlines()
	p = "".join(a)

	docbreaks = p.split("<doc>")
	attr_list = open(attr_list, "a")
	name_list = [line.strip() for line in open('attributions_names_WDI.csv')]

	for issue in docbreaks:
		paper = Issue(issue)
		for term in name_list:
			attr = paper.attribution(term)
			attr = re.sub('\n',' ',attr)
			date = paper.date()
			if attr != "":
				attr_list.write(date + "\t" + attr + '\n')

	attr_list.close()

if __name__=="__main__":
	generator = issueyielder("edit_batch_wvu_austria_ver01.pbd.metatext","attr_WDI_03032015.txt")
	# print generator


def cleanup(attribution):
	for line in attribution:
		pass