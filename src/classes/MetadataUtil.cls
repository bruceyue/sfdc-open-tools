/*
**
 * Author Bruce Yue
**/
public class MetadataUtil
{
    public class MetadataUtilException extends Exception { }
    
    public static MetadataService.MetadataPort createService()
    { 
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        return service;     
    }

    /**
     * Example helper method to interpret a SaveResult, throws an exception if errors are found
     **/
    public static void handleSaveResults(MetadataService.SaveResult saveResult)
    {
        // Nothing to see?
        if(saveResult==null || saveResult.success)
        {
            return;
        }
        // Construct error message and throw an exception
        if(saveResult.errors!=null) 
        {
            List<String> messages = new List<String>();
            messages.add((saveResult.errors.size()==1 ? 'Error ' : 'Errors ') + 
              'occured processing component ' + saveResult.fullName + '.');
            for(MetadataService.Error error : saveResult.errors)
            {
                messages.add(buildErrorInfo(error));
            }
            if(messages.size()>0)
            {
                throw new MetadataUtilException(String.join(messages, ' '));
            }
        }
        if(!saveResult.success)
        {
            throw new MetadataUtilException('Request failed with no specified error.');
        }
    }   

    /**
     * Example helper method to interpret a SaveResult, throws an exception if errors are found
     **/
    public static void handleDeleteResults(MetadataService.DeleteResult deleteResult)
    {
        // Nothing to see?
        if(deleteResult==null || deleteResult.success)
        {
            return;
        }
        // Construct error message and throw an exception
        if(deleteResult.errors!=null)
        {
            List<String> messages = new List<String>();
            messages.add(
              (deleteResult.errors.size()==1 ? 'Error ' : 'Errors ') + 
                'occured processing component ' + deleteResult.fullName + '.');
            for(MetadataService.Error error : deleteResult.errors)
            {
                messages.add(buildErrorInfo(error));
            }
            if(messages.size()>0)
            {
                throw new MetadataUtilException(String.join(messages, ' '));
            }
        }
        if(!deleteResult.success)
        {
            throw new MetadataUtilException('Request failed with no specified error.');     
        }
    }

    /**
     * Example helper method to interpret a UpsertResult, throws an exception if errors are found
     **/
    public static void handleUpsertResults(MetadataService.UpsertResult upsertResult)
    {
        // Nothing to see?
        if(upsertResult==null || upsertResult.success)
        {
            return;
        }
        // Construct error message and throw an exception
        if(upsertResult.errors!=null)
        {
            List<String> messages = new List<String>();
            messages.add(
              (upsertResult.errors.size()==1 ? 'Error ' : 'Errors ') + 
                'occured processing component ' + upsertResult.fullName + '.');
            for(MetadataService.Error error : upsertResult.errors)
            {
                messages.add(buildErrorInfo(error));
            }
              
          if(messages.size()>0)
            throw new MetadataUtilException(String.join(messages, ' '));
        }
        if(!upsertResult.success)
        {
            throw new MetadataUtilException('Request failed with no specified error.');             
        }
    }
    
    public static String buildErrorInfo(MetadataService.Error error)
    {
        return error.message + ' (' + error.statusCode + ').' + 
        ( error.fields!=null && error.fields.size()>0 ? 
        ' Fields ' + String.join(error.fields, ',') + '.' : '' );
    }
}