int[] temperatures;
int[] windSpeeds;
int[] windDirections;
int[] cloudCoverage;
int[] times;
int[] times_precip;
int[] humidity;
int[] precip;
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
PShape noaa;
PFont helvetica;
PFont coquette;
String zip;

void setup() {
  size (800, 700);
  zip = "60604";
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
  noaa = loadShape("Icons_noaa.svg");
  helvetica = loadFont("Helvetica-48.vlw");
  coquette = loadFont("Coquette-48.vlw");

  //Pull Data from National Oceanic and Atmospheric Administration Web Service <http://www.nws.noaa.gov/mdl/survey/pgb_survey/dev/rest.php>
  String url = "http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php?whichClient=NDFDgenMultiZipCode&lat=&lon=&listLatLon=&lat1=&lon1=&lat2=&lon2=&resolutionSub=&listLat1=&listLon1=&listLat2=&listLon2=&resolutionList=&endPoint1Lat=&endPoint1Lon=&endPoint2Lat=&endPoint2Lon=&listEndPoint1Lat=&listEndPoint1Lon=&listEndPoint2Lat=&listEndPoint2Lon=&zipCodeList="+zip+"&listZipCodeList=&centerPointLat=&centerPointLon=&distanceLat=&distanceLon=&resolutionSquare=&listCenterPointLat=&listCenterPointLon=&listDistanceLat=&listDistanceLon=&listResolutionSquare=&citiesLevel=&listCitiesLevel=&sector=&gmlListLatLon=&featureType=&requestedTime=&startTime=&endTime=&compType=&propertyName=&product=time-series&begin=2004-01-01T00%3A00%3A00&end=2018-10-13T00%3A00%3A00&Unit=e&temp=temp&pop12=pop12&wspd=wspd&wdir=wdir&sky=sky&wx=wx&rh=rh&wwa=wwa&Submit=Submit";
  String[] lines = loadStrings(url); //removed varialbe url
  String xml = join(lines, "" ); // Turn array into one long String
  String t = "";
  String ws = "";
  String wd = "";
  String cc = "";
  String hd = "";
  String prc = "";
  String timestring = "";
  String timestring_precip = "";
  t = giveMeTextBetween(xml, "<temperature", "</temperature>");
  ws = giveMeTextBetween(xml, "<wind-speed", "</wind-speed>");
  wd = giveMeTextBetween(xml, "<direction", "</direction>");
  cc = giveMeTextBetween(xml, "<cloud-amount", "</cloud-amount>");
  hd = giveMeTextBetween(xml, "<humidity", "</humidity>");
  prc = giveMeTextBetween(xml, "<probability-of-precipitation", "</probability-of-precipitation>");
  timestring = giveMeTextBetween(xml, "<layout-key>k-p3h", "</time-layout>");
  timestring_precip = giveMeTextBetween(xml, "<layout-key>k-p12h", "</time-layout>");
  temperatures = matchingValues(t);
  windSpeeds = matchingValues(ws);
  windDirections = matchingValues(wd);
  cloudCoverage = matchingValues(cc);
  humidity = matchingValues(hd);
  precip = matchingValues(prc);
  times = matchingTime(timestring);
  dates = matchingDate(timestring);  
  times_precip = matchingTime(timestring_precip);
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
  for (int ii = 0; ii < precip.length; ii++) {
    println("Rain"+ precip[ii]);
  }
}

void draw() {
  smooth();
  background (0);
  stroke(35);
  strokeWeight(2);
  //Labels
  textFont(coquette, 55);
  text("Weathercons", 258, 60 );
  textFont(helvetica, 20);
  text("Temperature", 25, 150 );
  text("Precipitation", 30, 250 );
  text("Cloud Coverage", 12, 350 );
  text("Wind", 55, 450 );
  text("Humidity", 45, 550 );
  shape(clock, 75, 608);
  shape(location, 75, 560);
  shape(noaa, 546, -23);
  fill(196);
  textFont(helvetica, 16);
  text("Date & Time", 25, 680);
  text("Zip Code", 37, 632);
  text("EXAMPLE", 198, 654);
  int dt_x = 340;
  for (int dt =0; dt<4; dt++) {
    textFont(helvetica, 18);
    text(dates[dt], dt_x, 668 );
    text(times[dt], dt_x+14, 689 );
    text(zip, dt_x, 625);
    dt_x +=125;
  }
  //Draw Grid
  for (int line_x = 175; line_x <width-100; line_x+=125) {
    for (int line_y = 600; line_y>0; line_y-=101) {
      line(line_x, 95, line_x, height-0);
      line(0, line_y, width-0, line_y);
    }
  }


  //Example
  int temp_example= 103;
  int rain_example = 36;
  int cloud_example = 7;
  int wind_example = 46;
  int humidity_example = 33;
  int tempex_x= 170;
  textFont(helvetica, 15);
  if (temp_example >=120) {
    shape(thermometer, tempex_x, 67);
    fill(255);
    textFont(helvetica, 15);
    text("Extremely Hot: "+temp_example+"°", tempex_x+5, 175);
  } else if (temp_example>=100) {
    shape(flame_full, tempex_x, 67);
    fill(255);
    textFont(helvetica, 15);
    text("Very Hot: "+temp_example+"°", tempex_x+23, 175);
  } else if (temp_example>= 85) {
    shape(flame_small, tempex_x, 67);
    fill(255);
    textFont(helvetica, 15);
    text("Hot: "+temp_example+"°", tempex_x+40, 175);
  } else if (temp_example>=68) {
    shape(t_shirt, tempex_x, 67);
    fill(255);
    textFont(helvetica, 12);
    text("Comfortable: "+temp_example+"°", tempex_x+30, 175);
  } else if (temp_example>=58) {
    shape(hoodie, tempex_x, 67);
    fill(255);
    textFont(helvetica, 15);
    text("Cool: "+temp_example+"°", tempex_x+35, 180);
  } else if (temp_example>= 32) {
    shape(scully, tempex_x, 67);
    fill(255);
    textFont(helvetica, 15);
    text("Cold: "+temp_example+"°", tempex_x+35, 180);
  } else if (temp_example>=14) {
    shape(snowflake, tempex_x, 67);
    fill(255);
    textFont(helvetica, 15);
    text("Very Cold: "+temp_example+"°", tempex_x+20, 180);
  } else {
    shape(snowman, tempex_x, 70);
    fill(255);
    textFont(helvetica, 15);
    text("Extremely Cold: "+temp_example+"°", tempex_x+0, 180);
  }


  text("Chance of Rain", 187, 265);
  text(+rain_example+"%", 226, 245);
  PShape water_dropex [] = new PShape [round(rain_example/10)];
  for (int ppx =0; ppx <= water_dropex.length-1; ppx++) {
    water_dropex[ppx] = loadShape("Icons_water_drop.svg");
    shape(water_dropex [ppx], random(111, 217), random(150, 220));
  }

  text("Cloud Coverage", 187, 365);
  text(+cloud_example+"%", 226, 345);
  PShape cloud_ex [] = new PShape [round(cloud_example/10)];
  for (int clx =0; clx <= cloud_ex.length-1; clx++) {
    cloud_ex[clx] = loadShape("Icons_cloud.svg");
    shape(cloud_ex [clx], random(111, 217), random(246, 316));
  }

  int windex_x = 169;
  int windex_y = 364;
  float xr_windex = 0;
  float yr_windex = 0;
  fill(255);
  xr_windex = map(float(wind_example), 0, 100, 0, 20 );
  yr_windex = map(float(wind_example), 0, 100, 0, 20 );
  shape(wind, random (windex_x-xr_windex, windex_x+xr_windex), random (windex_y-yr_windex, windex_y+yr_windex));
  textFont(helvetica, 18);
  text(+wind_example+" MPH", windex_x+50, 480);


  int humidex_x = 166;
  if (humidity_example <=40) {
    shape(turkey, humidex_x, 480);
    text("Dry", humidex_x+56, 577);
    text(+humidity_example+"%", humidex_x+54, 559);
  } else if (humidity_example<=80) {
    shape(hair, humidex_x, 480);
    text("Humid", humidex_x+45, 564);
    text(+humidity_example+"%", humidex_x+60, 540);
  } else if (humidity_example>= 81) {     
    shape(duck, humidex_x, 480);
    text("Muggy", humidex_x+46, 576);
    text(+humidity_example+"%", humidex_x+61, 557);
  } 


  //Draw Temperature Icons
  int temp_x = 300;
  for (int j =0; j<4; j++) {
    if (temperatures[j] >=120) {
      shape(thermometer, temp_x, 67);
      fill(255);
      textFont(helvetica, 15);
      text("Extremely Hot: "+temperatures[j]+"°", temp_x+5, 77);
    } else if (temperatures[j]>=100) {
      shape(flame_full, temp_x, 67);
      fill(255);
      textFont(helvetica, 15);
      text("Very Hot: "+temperatures[j]+"°", temp_x+23, 77);
    } else if (temperatures[j]>= 85) {
      shape(flame_small, temp_x, 67);
      fill(255);
      textFont(helvetica, 15);
      text("Hot: "+temperatures[j]+"°", temp_x+40, 77);
    } else if (temperatures[j]>=68) {
      shape(t_shirt, temp_x, 67);
      fill(255);
      textFont(helvetica, 12);
      text("Comfortable: "+temperatures[j]+"°", temp_x+30, 175);
    } else if (temperatures[j]>=58) {
      shape(hoodie, temp_x, 67);
      fill(255);
      textFont(helvetica, 15);
      text("Cool: "+temperatures[j]+"°", temp_x+35, 180);
    } else if (temperatures[j]>= 32) {
      shape(scully, temp_x, 67);
      fill(255);
      textFont(helvetica, 15);
      text("Cold: "+temperatures[j]+"°", temp_x+35, 180);
    } else if (temperatures[j]>=14) {
      shape(snowflake, temp_x, 67);
      fill(255);
      textFont(helvetica, 15);
      text("Very Cold: "+temperatures[j]+"°", temp_x+20, 180);
    } else {
      shape(snowman, temp_x, 70);
      fill(255);
      textFont(helvetica, 15);
      text("Extremely Cold: "+temperatures[j]+"°", temp_x+0, 180);
    }
    temp_x +=125;
  }

  //Draw Precipitation
  fill(255);
  text("Chance of Rain", 310, 265);
  text(+precip[0]+"%", 350, 245);
  text("Chance of Rain", 440, 265);
  text(+precip[0]+"%", 475, 245);
  text("Chance of Rain", 565, 265);
  text(+precip[1]+"%", 600, 245);   
  text("Chance of Rain", 690, 265);
  text(+precip[1]+"%", 725, 245);  

  PShape water_drop0 [] = new PShape [round(precip[0]/10)]; 
  for (int pp0 =0; pp0 <= water_drop0.length-1; pp0++) {
    water_drop0[pp0] = loadShape("Icons_water_drop.svg");        
    shape(water_drop0 [pp0], random(245, 340), random(150, 220));
  }

  PShape water_drop1 [] = new PShape [round(precip[0]/10)];
  for (int pp1 =0; pp1 <= water_drop1.length-1; pp1++) {  
    water_drop1[pp1] = loadShape("Icons_water_drop.svg");   
    shape(water_drop1 [pp1], random(379, 463), random(150, 220));
  }
  PShape water_drop2 [] = new PShape [round(precip[1]/10)];
  for (int pp2 =0; pp2 <= water_drop2.length-1; pp2++) {         
    water_drop2[pp2] = loadShape("Icons_water_drop.svg");      
    shape(water_drop2 [pp2], random(502, 585), random(150, 220));
  }
  PShape water_drop3 [] = new PShape [round(precip[1]/10)];
  for (int pp3 =0; pp3 <= water_drop3.length-1; pp3++) { 
    water_drop3[pp3] = loadShape("Icons_water_drop.svg");      
    shape(water_drop3 [pp3], random(630, 745), random(150, 220));
  }  

  //Draw Clouds
  frameRate(3);
  fill(255);
  text("Coverage", 335, 365);
  text(+cloudCoverage[0]+"%", 348, 345);
  text("Coverage", 460, 365);
  text(+cloudCoverage[1]+"%", 475, 345);
  text("Coverage", 585, 365);
  text(+cloudCoverage[2]+"%", 600, 345);
  text("Coverage", 715, 365);
  text(+cloudCoverage[3]+"%", 730, 345);

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
  int wind_y = 364;
  float x_rand = 0;
  float y_rand = 0;
  for (int wnds =0; wnds<4; wnds++) {
    x_rand = map(float(windSpeeds[wnds]), 0, 100, 0, 20 );
    y_rand = map(float(windSpeeds[wnds]), 0, 100, 0, 20 );
    fill(255);
    shape(wind, random(wind_x-x_rand, wind_x+x_rand), random(wind_y-y_rand, wind_y+y_rand));
    textFont(helvetica, 18);
    text(+windSpeeds[wnds]+" MPH", wind_x+50, 482);
    wind_x+=125;
  }
  //Draw Humidity Icons
  int humid_x = 295;
  for (int h =0; h<4; h++) {
    if (humidity[h] <=40) {
      shape(turkey, humid_x, 480);
      text("Dry", humid_x+56, 577);
      text(+humidity[h]+"%", humid_x+54, 559);
    } else if (humidity[h]<=80) {
      shape(hair, humid_x, 480);
      text("Humid", humid_x+45, 564);
      text(+humidity[h]+"%", humid_x+60, 540);
    } else if (humidity[h]>= 81) {     
      shape(duck, humid_x, 480);
      text("Muggy", humid_x+46, 576);
      text(+humidity[h]+"%", humid_x+61, 557);
    } 
    humid_x +=125;
  }
}


//Regex credit Daniel Shiffman <http://shiffman.net/2011/12/22/night-3-regular-expressions-in-processing/> 
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

//Regex credit Daniel Shiffman <http://shiffman.net/2011/12/22/night-3-regular-expressions-in-processing/> 
int[] matchingTime(String s) {
  String[][] y = matchAll(s, "<start-valid-time>(.*?)</start-valid-time>");
  int[] ints;
  ints = new int[y.length];
  for (int i = 0; i < y.length; i++) {
    ints[i] = int(giveMeTextBetween(y[i][1], "T", ":"));
  }
  return ints;
}

//Regex credit Daniel Shiffman <http://shiffman.net/2011/12/22/night-3-regular-expressions-in-processing/> 
String[] matchingDate(String s) {
  String[][] x = matchAll(s, "<start-valid-time>(.*?)</start-valid-time>");
  String[] dates;
  dates = new String[x.length];
  for (int i = 0; i < x.length; i++) {
    dates[i] = giveMeTextBetween(x[i][1], "-", "T");
  }
  return dates;
}

//Function to search for text from the XML file. Credit Daniel Shiffman <http://www.learningprocessing.com/examples/chapter-18/example-18-5/> 
String giveMeTextBetween(String xmlFile, String before, String after) {
  String found = "";
  int start = xmlFile.indexOf(before);    // Find the index of the beginning tag
  if (start == - 1) return"";       // If we don't find anything, send back a blank String
  start += before.length();         // Move to the end of the beginning tag
  int end = xmlFile.indexOf(after, start); // Find the index of the end tag
  if (end == -1) return"";          // If we don't find the end tag, send back a blank String
  return xmlFile.substring(start, end);    // Return the text in between
}

