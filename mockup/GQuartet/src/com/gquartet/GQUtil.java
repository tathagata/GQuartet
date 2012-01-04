package com.gquartet;

import java.util.Date;
import java.util.Map;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.*;
import com.gquartet.data.*;


import java.io.IOException;
import javax.servlet.http.*;
import java.util.logging.Logger;
import java.util.*;

public class GQUtil
{

  public static String GetHostUrl(HttpServletRequest request)
  {
    String protocol = request.getScheme();
    String domain = request.getServerName();
    String port=Integer.toString(request.getServerPort());
    String path=protocol + "://" + domain + ":" + port;
  
    return path;


  }

}


