//This script is used to add an avatar to the database; will most likely be a small termial object that will come with their purchase that they will touch to register.

string PHP_url = "http://www.slurphud.net/hudregister.php"; // replace the entire URL address


key owner = NULL_KEY;
integer listen_num = -1;
key http_request_id;
string firstname = "";
string lastname = "";
key toucher = NULL_KEY;
string toucher_name = "";
//================================================= 
            
//================================================= 
default
{
    state_entry()
    {
        toucher = NULL_KEY;
        firstname = "";
        lastname = "";
        owner = llGetOwner();
    }
    touch_start(integer total_number)
    {
        toucher_name = llDetectedName(0);
        toucher = llDetectedKey(0);
        
        list temp_list = llParseStringKeepNulls(toucher_name, [" "], []);    
        firstname = llList2String(temp_list, 0);
        lastname = llList2String(temp_list, 1);
        
        integer menu_chan = 0 - (integer)llFrand(2147483647);         
        listen_num  = llListen(menu_chan,"", toucher,"");                
        llDialog(toucher, "
        
Select Register to get started!

==========================", ["Register","Cancel"], menu_chan); // You can change the menu message
        llSetTimerEvent(60.0);
    }
    listen(integer channel, string name, key id, string message) 
    {
        llListenRemove(listen_num);
        if (message == "Register")
        {
            state register;
        }
        else if (message == "Cancel")
            llResetScript();
    }    
    timer()
    {
        llListenRemove(listen_num);
        llSetTimerEvent(0.0);
    }    
}
state register
{
    state_entry()
    {
        llSay(0,"Working. Please Wait.");        
        
        string http_body = llEscapeURL("uuidkey") +"="+ llEscapeURL((string)toucher) +"&"+ llEscapeURL("firstname") +"="+ llEscapeURL(firstname) +"&"+ llEscapeURL("lastname") +"="+ llEscapeURL(lastname);            

        http_request_id = llHTTPRequest(PHP_url, [HTTP_METHOD,"POST",HTTP_MIMETYPE,"application/x-www-form-urlencoded"], http_body);
    }
    http_response(key request_id, integer status, list metadata, string body)
    {
        if (request_id == http_request_id)
        {        
            if (body == "key_in_list")
            {
                llSay(0, toucher_name+", it looks like you're already registered in our system. Visit URL HERE to edit your details!");
            }    
            else if (body == "new_key_added")
            {
                llSay(0,"Thanks, "+toucher_name+", your avatar has been registered. Please visit URL HERE to edit your details!");
            }
            else
            {
               llSay(0,"Sorry, I'm unable to access the database at this moment.  Please try again later.");
            }                 
        }
        state default;
    }             
}
