int[] temperatures;
int[] windSpeeds;
int[] windDirections;
int[] cloudCoverage;
int[] times;
int[] humidity;
String[] dates;
PShape clock;
PShape cloud;
PShape duck;
PShape flame_full;
PShape flame_small;
PShape hair;
PShape hoodie;
PShape icecreamcone;
PShape scubamask;
PShape scully;
PShape snowflake;
PShape snowman;
PShape t_shirt;
PShape thermometer;
PShape turkey;
PShape water_drop;
PShape wind;
PShape location;
PFont helvetica;
PFont coquette;


void setup() {
  size (800, 700);
  //Load Icons: Free royalty-free icons from RoundsIcons.com via SmashingMagazine.com
  clock = loadShape("Icons_clock.svg");
  cloud = loadShape("Icons_cloud.svg");
  duck = loadShape("Icons_duck.svg");
  flame_full = loadShape("Icons_flame_full.svg");
  flame_small = loadShape("Icons_flame_small.svg");
  hair = loadShape("Icons_hair.svg");
  hoodie = loadShape("Icons_hoodie.svg");
  icecreamcone = loadShape("Icons_icecreamcone.svg");
  scubamask = loadShape("Icons_scubamask.svg");
  scully = loadShape("Icons_scully.svg");
  snowflake = loadShape("Icons_snowflake.svg");
  snowman = loadShape("Icons_snowman.svg");
  t_shirt = loadShape("Icons_t_shirt.svg");
  thermometer = loadShape("Icons_thermometer.svg");
  turkey = loadShape("Icons_turkey.svg");
  water_drop = loadShape("Icons_water_drop.svg");
  wind = loadShape("Icons_wind.svg");
  location = loadShape("Icons_location.svg");
  helvetica = loadFont("Helvetica-48.vlw");
  coquette = loadFont("Coquette-48.vlw");
  //Find Data
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
  //Data Test
  for (int i = 0; i < temperatures.length; i++) {
    println("Time ="+ times[i]);
    println(dates[i]);
    println("Clouds"+ cloudCoverage[i]);
    println("TEMP: " + temperatures[i]);
    println("W Speed: " + windSpeeds[i]);
    println("W Direction: " + windDirections[i]);
    println("Humid: " + humidity[i]);
  }

  //Create icons bases in weather data variable


  //println ("# of clouds"+ clouds0.length);

  //PShape clouds1 [] = new PShape [round(cloudCoverage[1]/10)];
  //PShape clouds2 [] = new PShape [round(cloudCoverage[2]/10)];
  //PShape clouds3 [] = new PShape [round(cloudCoverage[3]/10)];
}


void draw() {
  smooth();
  background (0);
  stroke(48);
  strokeWeight(2);
  //Labels
  textFont(coquette, 55);
  text("Weathercons", 258, 60 );
  textFont(helvetica, 20);
  text("Temperature", 25, 150 );
  text("Precipitation", 30, 250 );
  text("Cloud Coverage", 12, 350 );
  text("Temperature", 30, 450 );
  text("Humidity", 45, 550 );
  shape(clock, 75, 608);
  shape(location, 75, 560);
  int dt_x = 340;
  for (int dt =0; dt<4; dt++) {
    textFont(helvetica, 18);
    text(dates[dt], dt_x, 668 );
    text(times[dt], dt_x+14, 689 );
    dt_x +=125;
  }
  //Draw Grid
  for (int line_x = 175; line_x <width-100; line_x+=125) {
    for (int line_y = 600; line_y>0; line_y-=101) {
      line(line_x, 95, line_x, height-0);
      line(0, line_y, width-0, line_y);
    }
  }

  //Draw Temperature Icons
  int temp_x = 290;
  for (int j =0; j<4; j++) {
    if (temperatures[j] >=120) {
      shape(thermometer, temp_x, 67);
    } else if (temperatures[j]>=100) {
      shape(flame_full, temp_x, 67);
    } else if (temperatures[j]>= 85) {
      shape(flame_small, temp_x, 67);
    } else if (temperatures[j]>=68) {
      shape(t_shirt, temp_x, 67);
    } else if (temperatures[j]>=58) {
      shape(hoodie, temp_x, 67);
    } else if (temperatures[j]>= 32) {
      shape(scully, temp_x, 67);
    } else if (temperatures[j]>=14) {
      shape(snowflake, temp_x, 67);
    } else {
      shape(snowman, temp_x, 70);
    }
    temp_x +=125;
  }

  //Draw Clouds
  frameRate(5);

  PShape clouds0 [] = new PShape [round(cloudCoverage[0]/10)];
  for (int c0 =0; c0 <= clouds0.length-1; c0++) {
    clouds0[c0] = loadShape("Icons_cloud.svg");
    shape(clouds0 [c0], random(250, 340), random(246, 318));
  }

  PShape clouds1 [] = new PShape [round(cloudCoverage[1]/10)];
  for (int c1 =0; c1 <= clouds1.length-1; c1++) {
    clouds1[c1] = loadShape("Icons_cloud.svg");
    shape(clouds1 [c1], random(379, 463), random(246, 318));
  }

  PShape clouds2 [] = new PShape [round(cloudCoverage[2]/10)];
  for (int c2 =0; c2 <= clouds2.length-1; c2++) {
    clouds2[c2] = loadShape("Icons_cloud.svg");
    shape(clouds2 [c2], random(502, 585), random(250, 320));
  }

  PShape clouds3 [] = new PShape [round(cloudCoverage[3]/10)];
  for (int c3 =0; c3 <= clouds3.length-1; c3++) {
    clouds3[c3] = loadShape("Icons_cloud.svg");
    shape(clouds3 [c3], random(630, 745), random(246, 318));
  }

  //Draw Wind
  int wind_x = 292;
  for (int wnds =0; wnds<4; wnds++) {
    fill(255);
    shape(wind, wind_x, 364);
    textFont(helvetica, 18);
    text(+windSpeeds[wnds]+" MPH", wind_x+50, 482);
    wind_x+=125;
  }
  //Draw Humidity Icons
  int humid_x = 290;
  for (int h =0; h<4; h++) {
    if (humidity[h] <=40) {
      shape(turkey, humid_x, 480);
      text(+humidity[h]+"%", humid_x+57, 566);
    } else if (humidity[h]<=80) {
      shape(hair, humid_x, 480);
      text(+humidity[h]+"%", humid_x+60, 550);
    } else if (humidity[h]>= 81) {
      shape(duck, humid_x, 480);
      text(+humidity[h]+"%", humid_x+58, 566);
    } 
    humid_x +=125;
  }
}


//Regex from: 
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

//Regex from: 
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

//Regex from: 
String[] matchingDate(String s) {
  String[][] x = matchAll(s, "<start-valid-time>(.*?)</start-valid-time>");
  String[] dates;
  dates = new String[x.length];
  for (int i = 0; i < x.length; i++) {
    dates[i] = giveMeTextBetween(x[i][1], "-", "T");
  }
  return dates;
}

//Function to search for text from the XML file. Derived from: 
String giveMeTextBetween(String xmlFile, String before, String after) {
  String found = "";
  int start = xmlFile.indexOf(before);    // Find the index of the beginning tag
  if (start == - 1) return"";       // If we don't find anything, send back a blank String
  start += before.length();         // Move to the end of the beginning tag
  int end = xmlFile.indexOf(after, start); // Find the index of the end tag
  if (end == -1) return"";          // If we don't find the end tag, send back a blank String
  return xmlFile.substring(start, end);    // Return the text in between
}

