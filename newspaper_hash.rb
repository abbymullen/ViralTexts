#program to assign paper name to SN number

#read LOC file in and create hash
#assign key to paper name
#assign value to SN

hash = {}
File.open('newspapers_CA-LOC_list_trunc.txt') do |fp|
  fp.each do |line|
    title,city,state,dates,sn = line.chomp.split("\t")
    sn = sn.downcase!
    #hash[title] = sn
    hash[sn] = title
 
end
end

puts hash{"TheAlleghanian"}


#read pairwise file in
#fetch key for each SN
pairwise = File.open('test10pairwise.txt') do |pair|

end

#output to new file


