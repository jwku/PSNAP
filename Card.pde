/*
to convert all images in a folder use :
mogrify -format png *.*
*/

public static final String CARDS_FILE = "cards.json";

/**********/
class Card
{ 
    String name;
    PImage image;
    int cost;
    int power;
    String activate;
    String ability;
    
    Card(JSONObject obj)
    {
        name = obj.getString("name");
        image = loadImage( obj.getString("image") );
        cost = obj.getInt("cost");
        power = obj.getInt("power");
        activate = obj.getString("activate");
        ability = obj.getString("ability");
    }
   
}


/**********/
class CardManager
{ 
    HashMap<String,Card> cards;
    
    /**********/
    CardManager()
    {
        cards = new HashMap<String,Card>();
        
        JSONArray objs = loadJSONArray(CARDS_FILE);

        for (int i=0; i<objs.size(); i++) 
        {
            JSONObject obj = objs.getJSONObject(i); 
        
            String id = obj.getString("id");
            
            Card card = new Card(obj);
            
            if(cards.get(id)==null) { cards.put(id,card); }
            else { throw new RuntimeException("CARD MANAGER ERROR"); }
        }
    }
    
    /**********/
    Card get(String id) 
    {
        return cards.get(id);
    }

}
