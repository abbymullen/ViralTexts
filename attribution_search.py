import re

paper = open("edit_batch_wvu_austria_ver01.pbd.metatext")
attr_list = open("attributions_list.txt", "a")
name_list = [line.strip() for line in open('attributions_names_WDI.csv')]
print name_list

def check_regex(word, line, group_num):
	match = re.search(r"from the (\w*\s*" + word +")", line)
	if match:
		return match.group(group_num)
	match = re.search(r"The (\w*\s*" + word +")\s\w*\s*says", line)
	if match:
		return match.group(group_num)
	return ""

for line in paper:
	for term in name_list:
		match = check_regex(term, line, 1)
		if match != "":
			print match
			break
	

	