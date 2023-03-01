CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

if [[ -e student-submission/ListExamples.java ]]
then
    echo "Proper file found"
else
    echo "ListExamples.java not found"
fi

cp TestListExamples.java student-submission/

javac -cp $CPATH student-submission/*.java 2>java-errors.txt 
if [[ $? -ne 0 ]]
then
    cat java-errors.txt
    exit
fi
cp -r lib/ student-submission/lib
cd student-submission/
java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples 2>java-errors.txt 
if [[ $? -ne 0 ]]
then
    cat java-errors.txt
fi
