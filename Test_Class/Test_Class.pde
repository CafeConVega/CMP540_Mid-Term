class Weather {

  //function that turns the XML feed into a string (from YahooWeather sketch)
  // String getWeather (String zip) {
  String zip = "33130"; 
  String url = "http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php?whichClient=NDFDgenMultiZipCode&lat=&lon=&listLatLon=&lat1=&lon1=&lat2=&lon2=&resolutionSub=&listLat1=&listLon1=&listLat2=&listLon2=&resolutionList=&endPoint1Lat=&endPoint1Lon=&endPoint2Lat=&endPoint2Lon=&listEndPoint1Lat=&listEndPoint1Lon=&listEndPoint2Lat=&listEndPoint2Lon=&zipCodeList="+zip+"&listZipCodeList=&centerPointLat=&centerPointLon=&distanceLat=&distanceLon=&resolutionSquare=&listCenterPointLat=&listCenterPointLon=&listDistanceLat=&listDistanceLon=&listResolutionSquare=&citiesLevel=&listCitiesLevel=&sector=&gmlListLatLon=&featureType=&requestedTime=&startTime=&endTime=&compType=&propertyName=&product=time-series&begin=2004-01-01T00%3A00%3A00&end=2018-10-13T00%3A00%3A00&Unit=e&temp=temp&pop12=pop12&wspd=wspd&wdir=wdir&sky=sky&wx=wx&rh=rh&wwa=wwa&Submit=Submit";
  String[] lines = loadStrings(url);
  // Turn array into one long String
  String xml = join(lines, "" );
  //return xml;
  //  }

  //function that returns an array based on a specified variable (from Regex online example)
  int [] weatherVariable (String variable) {
    String lookfor = "<"+variable;
    String end = "</"+variable+">";
    String variableData = "";
    variableData = giveMeTextBetween(xml, lookfor, end);
    // Match this regular expression
    String[][] m = matchAll(variableData, "<value>(.*?)</value>");
    int[] var = new int[m.length];
    //int[] weatherVariable = new int [var.length];
    // println("Found '" + m[i][1] + "' inside a tag.");
    for (int x = 0; x< var.length; x++) {  
      for (int i = 0; i < m.length; i++) {
        var[x] = int(m[i][1]);
        //println("Assigned'" + var[x]);
      }
    }
    return var;
  }


  //function that returns a string of text (from YahooWeather sketch)
  String giveMeTextBetween(String s, String before, String after) {
    String found = "";
    int start = s.indexOf(before);    // Find the index of the beginning tag
    if (start == - 1) return"";       // If we don't find anything, send back a blank String
    start += before.length();         // Move to the end of the beginning tag
    int end = s.indexOf(after, start); // Find the index of the end tag
    if (end == -1) return"";          // If we don't find the end tag, send back a blank String
    return s.substring(start, end);    // Return the text in between
  }
}

