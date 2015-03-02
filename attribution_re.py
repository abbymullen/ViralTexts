import re

class Issue():
	def __init__(self, doc):
		self.doc = doc

	def attribution(self,word):
		match = re.search(r"[Ff]rom t[hilb]+e (\w*\.*\s*\w*\.*\s*" + word + ")", self.doc)
		if match:
			#match = re.sub("\n"," ",match.group(1))
			return match.group()
		match = re.search(r"The (\w*\.*\s*\w*\.*\s*" + word + ")\s\w*\s*says", self.doc)
		if match:
			#match = re.sub("\n"," ",match.group(1))
			return match.group()
		match = re.search(r"special to the (\w*\.*\s*\w*\.*\s*" + word + ")", self.doc)
		if match:
	 		#match = re.sub("\n"," ",match.group(1))
	 		return match.group()
	 	match = re.search(r"[Bb]y the last (\w*\.*\s*\w*\.*\s*" + word + ")", self.doc)
	 	if match: 
	 		#match = re.sub("\n"," ",match.group(1))
	 		return match.group()
	 	match = re.search(r"the correspondent of the (\w*\.*\s*\w*\.*\s*" + word + ")", self.doc)
	 	if match: 
	 		#match = re.sub("\n"," ",match.group(1))
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
			date = paper.date()
			if attr != "":
				attr_list.write(date + "\t" + attr + '\n')

	attr_list.close()

if __name__=="__main__":
	generator = issueyielder("25K_WDI.txt","attr_test.txt")
	# print generator
