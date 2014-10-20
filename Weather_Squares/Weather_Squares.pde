int[] temperatures;
int[] windSpeeds;
int[] windDirections;
int[] cloudCoverage;
int[] times;
int[] humidity;
String[] dates;

void draw() {
  background (0);
  stroke(72);
  strokeWeight(2);
  // line(150, 0, 150, height-0);
  line(0, height-80, width, height-80);
  for (int l = 90; l <height-100; l+=86) {
  for(int h = 150; h< width-5; h+=86){
    rect(0,l,86,86);
    rect(
  }
  }
  //float ws_color = map(windSpeeds[0], 0, 5, 0, 255);
  // fill(ws_color);
  //rect(width/2, height/2, 50, 50);
}

void setup() {
  size (800, 700);
  String url = "http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php?whichClient=NDFDgenMultiZipCode&lat=&lon=&listLatLon=&lat1=&lon1=&lat2=&lon2=&resolutionSub=&listLat1=&listLon1=&listLat2=&listLon2=&resolutionList=&endPoint1Lat=&endPoint1Lon=&endPoint2Lat=&endPoint2Lon=&listEndPoint1Lat=&listEndPoint1Lon=&listEndPoint2Lat=&listEndPoint2Lon=&zipCodeList=33134&listZipCodeList=&centerPointLat=&centerPointLon=&distanceLat=&distanceLon=&resolutionSquare=&listCenterPointLat=&listCenterPointLon=&listDistanceLat=&listDistanceLon=&listResolutionSquare=&citiesLevel=&listCitiesLevel=&sector=&gmlListLatLon=&featureType=&requestedTime=&startTime=&endTime=&compType=&propertyName=&product=time-series&begin=2004-01-01T00%3A00%3A00&end=2018-10-13T00%3A00%3A00&Unit=e&temp=temp&pop12=pop12&wspd=wspd&wdir=wdir&sky=sky&wx=wx&rh=rh&wwa=wwa&Submit=Submit";
  String[] lines = loadStrings(url); //removed varialbe url
  String xml = join(lines, "" ); // Turn array into one long String
  String t = "";
  String ws = "";
  String wd = "";
  String cc = "";
  String hd = "";
  String timestring = "";
  t = giveMeTextBetween(xml, "<temperature", "</temperature>");
  ws = giveMeTextBetween(xml, "<wind-speed", "</wind-speed>");
  wd = giveMeTextBetween(xml, "<direction", "</direction>");
  cc = giveMeTextBetween(xml, "<cloud-amount", "</cloud-amount>");
  hd = giveMeTextBetween(xml, "<humidity", "</humidity>");
  timestring = giveMeTextBetween(xml, "<layout-key>k-p3h", "</time-layout>");
  temperatures = matchingValues(t);
  windSpeeds = matchingValues(ws);
  windDirections = matchingValues(wd);
  cloudCoverage = matchingValues(cc);
  humidity = matchingValues(hd);
  times = matchingTime(timestring);
  dates = matchingDate(timestring);
  for (int i = 0; i < temperatures.length; i++) {

    println("Time ="+ times[i]);
    println(dates[i]);
    println("Clouds"+ cloudCoverage[i]);
    println("TEMP: " + temperatures[i]);
    println("W Speed: " + windSpeeds[i]);
    println("W Direction: " + windDirections[i]);
    println("Humid: " + humidity[i]);
  }
}

int[] matchingValues(String s) {
  String[][] m = matchAll(s, "<value>(.*?)</value>");
  int[] ints;
  ints = new int[m.length];
  for (int i = 0; i < m.length; i++) {
    ints[i] = int(m[i][1]);
    // println("Assigned'" + i + " " + ints[i]);
  }
  return ints;
}

int[] matchingTime(String s) {
  String[][] y = matchAll(s, "<start-valid-time>(.*?)</start-valid-time>");
  int[] ints;
  ints = new int[y.length];
  for (int i = 0; i < y.length; i++) {
    ints[i] = int(giveMeTextBetween(y[i][1], "T", ":"));
    if (ints [i] >12) {
      ints [i]-= 12;
    }
  }
  return ints;
}


String[] matchingDate(String s) {
  String[][] x = matchAll(s, "<start-valid-time>(.*?)</start-valid-time>");
  String[] dates;
  dates = new String[x.length];
  for (int i = 0; i < x.length; i++) {
    dates[i] = giveMeTextBetween(x[i][1], "-", "T");
  }
  return dates;
}



String giveMeTextBetween(String xmlFile, String before, String after) {
  String found = "";
  int start = xmlFile.indexOf(before);    // Find the index of the beginning tag
  if (start == - 1) return"";       // If we don't find anything, send back a blank String
  start += before.length();         // Move to the end of the beginning tag
  int end = xmlFile.indexOf(after, start); // Find the index of the end tag
  if (end == -1) return"";          // If we don't find the end tag, send back a blank String
  return xmlFile.substring(start, end);    // Return the text in between
}

