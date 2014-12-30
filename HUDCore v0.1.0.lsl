//php page URL
string getstats = "http://slurphud.net/getstats.php";
//define a key that will contain the key of the request to send the data to the database.
key requestKey;
//define a list to contain the parameters of the http request.
list paramget = [HTTP_METHOD, "GET"];
list parampost = [HTTP_METHOD, "POST"];

default
{
    touch_start(integer numDetected)
    {
        //define key of avatar
        key toucher = llDetectedKey(0);
        //define a string to contain the body of the request.
        string body = "";
        //define a string to contain the complete url of the request.
        string URL = getstats + "?" + "uuidkey=" + (string)toucher;
        
        //send the request
        requestKey = llHTTPRequest(URL, paramget, body);
        //DEBUG
        llOwnerSay(URL + body);
    }
    
    
    //this function runs when we hear back from the php page.
    http_response(key request_id, integer status, list metadata, string body)
    {
        //check that the request_id matches our previously defined requestKey. A security measure.
        if(request_id == requestKey)
        {
            if (body == "no_row")
            {
                llOwnerSay("Sorry, no info found.");
            }
            else if (body == "")
            {
                llOwnerSay("Status: " + (string)status);
                llOwnerSay("Nothing here.");
            }
            else
            {
                llOwnerSay("Status: " + (string)status);
                llOwnerSay("Body: " + body);
            }
        }
        else
        {
            llOwnerSay("Error: IDKey Check.");
        }    
    }
}
