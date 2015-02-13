class Newspaper <
	Struct.new(:persistent_link, :state, :title, :lccn, :oclc, :issn, :issue_no, :first_issue, :last_issue, :more)
# def print_csv_record
#     persistent_link.length==0 ? printf(",") : printf("\"%s\",", persistent_link)
#     title.length==0 ? printf(",") : printf("\"%s\",", title)
#     state.length==0 ? printf("") : printf("\"%s\"", state)
#     lccn.length==0 ? printf("") : printf("\"%s\"", lccn)
#     printf("\n")
#   end
# end

papers = Array.new

f = File.open("newspapers_CA-LOC_complete_list.txt", "r")
f.each_line { |line|
fields = line.split('|')
n = Newspaper.new
n.title = fields[2]
n.persistent_link = fields[0]
n.state = fields[1]
n.lccn = fields[3]
papers.push(n)
}

#papers = papers.sort_by { |n| [ n.title, n.state ] 
# papers.each {|n| 
# 	puts n.title, n.state}
puts fields