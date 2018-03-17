# Word2vec
### Using PubMed publications as training data.
Word2vec is one of the most popular methods from natural language.<br />
<br />

The word embeddings technique have the effectively proabliliy to capture the semantic meanings of the word.<br />
<br />

There are numerous of sources such as online reviews, social network services and scientific publications, <br />

have been applied to textual data.
<br />
<br />
<br />

PubMed comprises more than 28 million citations for biomedical literature from MEDLINE, life science journals, 

and online books.<br />

    Here is an example code of using scientific publications from PubMed website.
    
    
## Download MEDLINE format file from PubMed website.


![image](https://github.com/Imshepherd/wordVectors-R-PubMed-Resourse/blob/master/example_picture.png)









中文說明：

詞映射技術文章來源 – 醫學文獻

透過PuMed搜尋引擎下載自2016年至2000年所有公開刊登之文獻摘要，檢索方式為："2000"[Date - Publication] : "2016"[Date - Publication]，如文獻下載示意圖，並以MEDLINE格式下載，再使用R軟體之正規表達式擷取標題以及摘要部分，並去除標點符號、括號內文字以及各式標題，例如：BACKGROUND、METHODS等文字，除此之外將所有數字轉換成數字0，以及將單字大寫轉換成小寫，以便進行詞映射模組訓練。

    關鍵字：詞映射   詞向量  詞鑲嵌
    

