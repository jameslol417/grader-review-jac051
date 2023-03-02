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
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > errors.txt

exitCode=$?

error=$(grep -m1 "testMergeRightEnd" errors.txt) 
expected=$(grep -m1 "expected" errors.txt)

if [[ $exitCode -ne 0 ]]
then
    echo "Exit code:" $exitCode 
    echo ""
    echo "Test failed:" $error
    echo "Check if your merge method works as intended for the following 
    2 arrays: {\"a\", \"b\", \"c\"}, {\"a\", \"b\"}."
    echo $expected
    echo ""
    echo "Errors found, grade: Fail"
    exit $exitCode
else
    echo "No errors found, grade: Pass"
fi



