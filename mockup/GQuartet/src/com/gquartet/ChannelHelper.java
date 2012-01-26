package com.gquartet;

import com.gquartet.data.*;

import java.util.Date;
import java.util.Map;
import java.util.HashMap;

import com.google.appengine.api.channel.*;
import java.io.IOException;
import javax.servlet.http.*;
import javax.servlet.*;
import java.util.logging.Logger;

public class ChannelHelper
{
    public static final String CLIENTID_LIST = "CLIENTID_LIST";
     static final Logger log = Logger.getLogger(ChannelHelper.class.getName()); 

    public static String getChannelKey(String clientName, String talkName)
    {
      return clientName + "_" + talkName;
    }

    public static void addToAppContextList(ServletContext appContext, String clientId )
    {
        //Add list of client to list
        HashMap<String,String> channelKeyList = (HashMap<String,String>)appContext.getAttribute(CLIENTID_LIST);
        if ( channelKeyList == null )
        {
          channelKeyList = new HashMap<String,String>();
        }

        log.warning("Adding clientId = " + clientId + "to appContext." );
        channelKeyList.put(clientId,clientId);
        appContext.setAttribute("CLIENTID_LIST", channelKeyList); 
 

    }

    public static String addChannel(ServletContext appContext, String clientId)
    {
        // Create Channel and client.
        ChannelService channelService = ChannelServiceFactory.getChannelService();
        String token = channelService.createChannel(clientId);
        

        addToAppContextList(appContext, clientId);

        log.warning("Returning token = " + token + "for clientId = " + clientId );
        return token;

    }

    public static void broadcastSlideChange(ServletContext appContext, long slideNo )
    {
        log.warning("Broadcasting slide change = " + slideNo );

        //broadcast slide change.
        ChannelService channelService = ChannelServiceFactory.getChannelService();
        HashMap<String,String> channelKeyList = (HashMap<String,String>) appContext.getAttribute(CLIENTID_LIST);
        if ( channelKeyList != null ) 
        {
          for ( String channelKey : channelKeyList.keySet() )
          {
            log.warning("Pushing message onto channel with key = " + channelKey);
            channelService.sendMessage(new ChannelMessage(channelKey, "SlideNo:"+slideNo ));
          }
        }
    }

    public static void broadcastNewQuestion(ServletContext appContext, Question q )
    {
        log.warning("Broadcasting new question change = " + q.questionText );

        //broadcast new question.
        ChannelService channelService = ChannelServiceFactory.getChannelService();
        HashMap<String,String> channelKeyList = (HashMap<String,String>) appContext.getAttribute(CLIENTID_LIST);
        if ( channelKeyList != null ) 
        {
          for ( String channelKey : channelKeyList.keySet() )
          {
            log.warning("Pushing new question  onto channel with key = " + channelKey);
            
            channelService.sendMessage(new ChannelMessage(channelKey, "\"Question\" : { " + q.toJSON() + " }" ));


          }
        }
    }



    public static void removeFromAppList(ServletContext appContext, String clientId)
    {
      HashMap<String,String> list = (HashMap<String,String>)appContext.getAttribute(CLIENTID_LIST);
      if ( list == null ) return;

      log.warning("Removing channel with clientId = " + clientId + "from list.");
      try
      {
        list.remove(clientId);
      }
      catch(Exception ex)
      {
          log.warning("error removing channel client id reference from appContext list " + e.getMessage());
      }

    }



}

