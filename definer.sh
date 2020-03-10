#/bin/bash
echo "----------------"
echo "Vocabulary agent"
echo "By Jack Hudson  "
echo "----------------"
echo "Doing some necessary calculations to start..."

#Making some files to store the data
touch definitions.txt
touch sentences.txt
echo "Ready! Now onto the work..."
for word in $(cat words.txt); do # This loop runs through every word in the input file
	echo "Defining ${word}..."
	wget -O "index.html" -q "learnersdictionary.com/definition/${word}" # Gets the HTML
	touch tempOne.txt
	cat index.html | grep "def_text" > tempOne.txt
	sed -n 1p tempOne.txt | cut -d '>' -f 2 | cut -d '<' -f 1 >> definitions.txt
	touch temp.txt
	cat index.html | grep "vi_content" > temp.txt # Stores all the sentences in a file
	sed -n 1p temp.txt | awk '{gsub("<div class=\"vi_content\">", "");print}' | awk '{gsub("<em class=\"mw_spm_it\">", "");print}' | awk '{gsub("</em>", "");print}' | awk '{gsub("</div>", "");print}' >> sentences.txt
	rm index.html
	rm temp.txt
	rm tempOne.txt
done
echo "All done! Please check the definitions.txt and sentences.txt files for your requested data!"
