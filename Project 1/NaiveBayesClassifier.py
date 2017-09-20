# -*- coding: utf-8 -*-
"""
Created on Mon Sep 26 10:55:06 2016

@author: SyedAbu
"""
import os
import math
import re
from nltk.corpus import stopwords
from nltk.stem import PorterStemmer

stopWords = stopwords.words('english')
classes={}
wordCountClass={}


def preProcessingTrainingClass(pathFiles,listFiles,uniqueWordsClass) :
    count = 0;
    classData = {}
    wordCount = 0
    for file in listFiles:
        f = open(os.path.join(pathFiles, file))
        regEx = re.sub('[^a-zA-Z]+', ' ', f.read())
        words = regEx.split()
        newWords = []
        for w in words:
            if w.lower() not in stopWords:
                newWords.append(w.lower());
                #print ("New Words: "+str(newWords))
        stemWords = []
        ps = PorterStemmer()
        for wordList in newWords:
            stemWords.append(ps.stem(wordList))
            count += 1;
            #print("Stem Words:"+str(stem_words))
        
        for s in stemWords:
            flag = 0;
            wordCount+=1
            if s in classData:
                flag = 1;
                classData[s] += 1;
            if flag == 0:
                classData[s] = 1
            if s not in uniqueWordsClass:
                uniqueWordsClass[s]=1;

    return classData,wordCount,uniqueWordsClass;

def trainingClassifer(uniqueWords, f1):
    trainPath = "Data/Train/"
    trainDir=os.listdir(trainPath)
    for fileDir in trainDir:
        listFiles = []
        pathFiles=trainPath+fileDir+'/';
        files=os.listdir(pathFiles)
        for file in files:
             listFiles.append(file)
             
        class_data,total_words,uniqueWords=preProcessingTrainingClass(pathFiles,listFiles, uniqueWords)
        #print(fileDir,class_data)
        f1.write(fileDir)
        f1.write("\n")
        f1.write(str(class_data))
        f1.write("\n")
        classes[fileDir]=class_data
        wordCountClass[fileDir]=total_words

    return uniqueWords
    
def preProcessingTestfile(pathFiles,file, testClassData):
    f = open(os.path.join(pathFiles, file))
    regEx = re.sub('[^a-zA-Z]+', ' ', f.read())
    words = regEx.split()
    newWords = []
    for w in words:
        if w.lower() not in stopWords:
            newWords.append(w.lower());
    stem_words = [];
    ps = PorterStemmer()
    for wordList in newWords:
        stem_words.append(ps.stem(wordList))
    for s in stem_words:
        if s not in testClassData:
            testClassData.append(s)
    return testClassData
        

def classProbability(allClasses,testClassData,Vocabulary,wordCount):
    probClass={}
    for Class, Count in allClasses.items():
        prob = 0;
        for words in testClassData:
            if words in Count:
                prob += math.log(((Count[words]+1)/(wordCount[Class]+Vocabulary+1)))
            else:
                prob += math.log(( 1/ (wordCount[Class]+Vocabulary+1)))

        prob = prob / len(allClasses)
        probClass[Class]=prob
    return max(probClass,key =probClass.get)

def main():
    uniqueWordsClass={}
    correctPredicted=0;
    f = open('PredictedClasses.txt', 'w')
    f1 = open('ClassesData.txt', 'w')
    
    uniqueWordsClass= trainingClassifer(uniqueWordsClass, f1)
    

    testPath = "Data/Test/"
    testDir=os.listdir(testPath)
    fileCount=0;
    for fileDir in testDir:
        listFiles = []
        pathFiles=testPath+fileDir+'/';
        files=os.listdir(pathFiles)
        for file in files:
            listFiles.append(file)
        for testfile in listFiles:
            fileCount=fileCount+1;
            testClassData=[]
                    
            testClassData = preProcessingTestfile(pathFiles, testfile, testClassData)

            predicted_file=classProbability(classes,testClassData,len(uniqueWordsClass),wordCountClass)
            if predicted_file == fileDir:
                correctPredicted=correctPredicted+1
            #print(predicted_file)
            f.write(predicted_file)
            f.write("\n")

    
    print("Total tested Files: "+str(fileCount))
    print("Correct Predicted Files: "+str(correctPredicted))
    Accuracy=(correctPredicted/fileCount) * 100
    print("Accuracy: "+str(Accuracy)+"%")
    f.close()
    f1.close()
main()