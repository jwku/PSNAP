public static final String OPTIONS_FILE = "options.json";

/**********/
class Options
{
    String path;
    int bg_color;
    int fg_color;
    PImage bg_image;

    /**********/
    Options()
    {
        int val = 0;
        String s = "";

        JSONObject obj = loadJSONObject(OPTIONS_FILE);
            
        path = obj.getString("path");

        s = obj.getString("bg_color");
        val = Integer.parseInt(s,16);
        bg_color = color(red(val), green(val), blue(val));

        s = obj.getString("fg_color");
        val = Integer.parseInt(s,16);
        fg_color = color(red(val), green(val), blue(val));

        s = obj.getString("bg_image");
        bg_image = loadImage(s);   
    }
    
}
