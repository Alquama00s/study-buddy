```
AppDocDirectory
    -firebase.app(config json)
    -app1.dir
        -app1.hiveInit('fire-app1').dir
            -schema.hiveBox('fire-.app1')
                rootcollection.key:[]
                collectionid.key : Collection
                collectionid.key : Collection
                .
                .
            -doc1.hiveBox(hash(address))-> all the docs in this app
            -doc2.hiveBox()
            .
            .
    -app2.hive
    .
    .
    .

```

```
Collection.map(fire-app1-collectionname)
    docids.key :[
        'docname1',
        'docname2',
        .
        .
        .
    ]
   
    
```
```
Documents.hiveBox(fire-app1-collectionname-docname)
    address:
    collections-ids.key:[],
    lfire-.collectionid.key:Collection,
    lfire-.collectionid.key:Collection,
    .
    .
    
    key:value,
    key:value,
    key:value,
    .
    .
    .
    
```
```
Library control structure
firebase -> firestore -> Collection -> Documents 
```
```
addresses
root collection :
    face value - collection-name
    value - fireapp-.collection-name
documents : 
    face value - some-root-collecton/somedoc/somecoll/somedoc
    value -
collection :
    face value - some-root-collecton/somedoc/somecoll/somedoc/somecoll
    value -
```
# Problems
    - hive.init is called more than once
    - 