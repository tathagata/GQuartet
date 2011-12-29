package com.gquartet.data;

import java.util.Date;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.*;

import java.util.logging.Logger;


class GQDataConstants
{
  /*Entity Names*/
  public static String TALK ="Talk";
  public static String SLIDE = "Slide";
  public static String QUESTION ="Question";
  public static String COMMENTS = "Comments"; 

}


public class GQDataStore {

  static final Logger log = Logger.getLogger(GQDataStore.class.getName()); 
  public static DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

  public static void main(String args[])
  {
    TestNewEmployee();
  }

  public static String AddNewTalk(String resourceId, Date sessionDate, String talkName )
  {

    Entity talk = new Entity(GQDataConstants.TALK);
    talk.setProperty("Date", new Date());
    talk.setProperty("DocumentId", resourceId);
    talk.setProperty("Name", talkName);

    datastore.put(talk);

    return KeyFactory.keyToString(talk.getKey());

  }





  public static void TestNewEmployee()
  {

    Entity employee = new Entity("Employee", "Emp2");;
    employee.setProperty("firstName", "Antonio");
    employee.setProperty("lastName", "Salieri");
    Date hireDate = new Date();
    employee.setProperty("hireDate", hireDate);
    employee.setProperty("attendedHrTraining", true);

    datastore.put(employee);

    Entity address = new Entity("EmpAddr", "addr1", employee.getKey());
    address.setProperty("zip", 60612);
    datastore.put(address);
  }

  public static Entity getEmployeeByKey(int id)
  {
    try
    {
      Key k = KeyFactory.createKey("Employee", id);
      return datastore.get(k);
    }
    catch ( Exception ex)
    {
      log.warning(ex.getMessage());
    }

    return null;
  } 




}





/// SAMPLE:
//
//
//
//http://code.google.com/appengine/docs/java/javadoc/com/google/appengine/api/datastore/package-summary.html
//
//
//// Get a handle on the datastore itself
// DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
//
//  // Lookup data by known key name
//   Entity userEntity = datastore.get(KeyFactory.createKey("UserInfo", email));
//
//    // Or perform a query
//     Query query = new Query("Task");
//      query.addFilter("dueDate", Query.FilterOperator.LESS_THAN, today);
//       for (Entity taskEntity : datastore.prepare(query).asIterable()) {
//          if ("done".equals(taskEntity.getProperty("status"))) {
//               datastore.delete(taskEntity);
//                  } else {
//                       taskEntity.setProperty("status", "overdue");
//                            datastore.put(taskEntity);
//                               }
//                                }
//
