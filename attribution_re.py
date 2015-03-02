import re

def issueyielder(filename):
	text = open(filename, "r")
	a = text.readlines()
	p = "".join(a)

	docbreaks = p.split("<doc>")

	for issue in docbreaks:
		yield issue



class Issue():
	def __init__(self, doc):
		self.doc = doc

	def attribution(self,word):
		match = re.search(r"[Ff]rom t[hilb]+e (\w*\.*\s*\w*\.*\s*" + word + ")", self.doc)
		if match:
			match = re.sub("\n"," ",match.group(1))
			return match
		match = re.search(r"The (\w*\.*\s*\w*\.*\s*" + word + ")\s\w*\s*says", self.doc)
		if match:
			match = re.sub("\n"," ",match.group(1))
			return match
		match = re.search(r"special to the (\w*\.*\s*\w*\.*\s*" + word + ")", self.doc)
		if match:
	 		match = re.sub("\n"," ",match.group(1))
	 		return match
	 	match = re.search(r"[Bb]y the last (\w*\.*\s*\w*\.*\s*" + word + ")", self.doc)
	 	if match: 
	 		match = re.sub("\n"," ",match.group(1))
	 		return match
	 	match = re.search("the correspondent of the (\w*\.*\s*\w*\.*\s*" + word + ")", self.doc)
	 	if match: 
	 		match = re.sub("\n"," ",match.group(1))
	 		return match
		return ""

	def date(self):
		match = re.search(r"<date>(.*)</date>",self.doc)
		if match:
			return match.group(1)



if __name__=="__main__":
	generator = issueyielder("edit_batch_wvu_austria_ver01.pbd.metatext")
	name_list = [line.strip() for line in open('attributions_names_WDI.csv')]
	attr_list = open("attributions_list.txt_2", "a")
	for issue in generator:
		issue = generator.next()
		paper = Issue(issue)
		for term in name_list:
			attr = paper.attribution(term)
			date = paper.date()

			if attr != "":
				attr_list.write(date + "\t" + attr + '\n')
	attr_list.close()