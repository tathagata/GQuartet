package com.gquartet.data;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.*;

import java.util.*;
import java.lang.StringBuilder;

public class SearchResult
{
    public String talkKey;
    public  long slideNo;
    public  String text;
    public  String talkName;

   public SearchResult(String _talkKey, String _talkName, long _slideNo, String _text )
   {
     talkKey = _talkKey;
     slideNo = _slideNo;
     talkName = _talkName;
     text = _text;
   }
}




