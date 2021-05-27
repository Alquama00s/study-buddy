```
AppDocDirectory
    -firebase.dir
        -app1.dir
            -app1.hiveBox('fire-app1')
                rootcollection.key:[]
                collectionid.key : Collection
                collectionid.key : Collection
                .
                .
            -doc1.hiveBox('name according to convention')-> all the docs in this app
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
    collections.key:{
        ids.key:[],
        collectionid.key:Collection,
        collectionid.key:Collection,
        .
        .
    }
    documents.key:{
        key:value,
        key:value,
        key:value,
        .
        .
        .
    }
```