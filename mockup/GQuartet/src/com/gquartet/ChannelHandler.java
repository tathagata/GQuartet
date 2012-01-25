package com.gquartet;

import java.io.IOException;
import javax.servlet.http.*;
import javax.servlet.*;
import java.util.logging.Logger;
import java.util.*;
import com.google.appengine.api.channel.*;

@SuppressWarnings("serial")
public class ChannelHandler extends HttpServlet {

  static final Logger log = Logger.getLogger(ChannelHandler.class.getName()); 


	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

      ChannelService channelService = ChannelServiceFactory.getChannelService();
      ChannelPresence presence = channelService.parsePresence(req);

      log.warning("Inside channel_presence handler");
      String status = (presence.isConnected())?"connected":"disconnected";
      log.warning(presence.clientId() + " is currently = " + status); 

      if ( presence.isConnected() == false )
      {
        ServletContext appContext = getServletConfig().getServletContext();
        ChannelHelper.removeFromAppList(appContext, presence.clientId());
      }

      log.warning("Listener's job completed...");


}
}




