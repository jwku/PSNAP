public static final String PLAY_FILE = "PlayState.json";
public static final String COLLECTION_FILE = "CollectionState.json";

/**********/
class Deck
{ 
    String name;
    ArrayList<Card> cards;
    
    /**********/
    Deck(JSONObject obj)
    {
        name = obj.getString("Name");
        
        JSONArray _cards = obj.getJSONArray("Cards");
        
        cards = new ArrayList<Card>();
        
        for (int i=0; i<_cards.size(); i++) 
        {
            JSONObject _card =  _cards.getJSONObject(i); 
        
            String card_id = _card.getString("CardDefId");
            
            Card card = CARDMANAGER.get(card_id);
            
            if(card==null || cards.contains(card)) { throw new RuntimeException("DECK MANAGER ERROR " + card_id);  }
            else { cards.add(card); }
        }

        //sort the array by cost
        Collections.sort(cards, new Comparator<Card>(){
            public int compare (Card a, Card b) {
                if(a.cost==b.cost) { return 0; }
                return a.cost < b.cost ? -1 : 1;
            }
        });
    }
}


/**********/
class DeckManager extends TimerTask 
{ 
    HashMap<String,Deck> decks;
    File decks_file;
    long decks_ts;
    
    Deck selected;
    File selected_file;
    long selected_ts;
    
    java.util.Timer timer;
    
    /**********/
    DeckManager()
    {
        decks_file = new File(OPTIONS.path + COLLECTION_FILE);
        decks_ts = decks_file.lastModified();
        update_decks();
        
        selected_file = new File(OPTIONS.path + PLAY_FILE);
        selected_ts = selected_file.lastModified();
        update_selected();

        timer = new java.util.Timer();
    
        timer.schedule( this, new Date(), 1000 );
    }
    
    /**********/
    void update_decks()
    {
        decks = new HashMap<String,Deck>();
        
        JSONObject obj = loadJSONObject(decks_file);

        JSONObject serverstate = obj.getJSONObject("ServerState");
        
        JSONArray _decks = serverstate.getJSONArray("Decks");

        for (int i=0; i<_decks.size(); i++) 
        { 
            JSONObject _deck = _decks.getJSONObject(i); 
        
            String deck_id = _deck.getString("Id");
            
            Deck deck = new Deck(_deck);
            
            if(decks.get(deck_id)==null) { decks.put(deck_id,deck); }
            else { throw new RuntimeException("DECK MANAGER ERROR"); }
        }
        
    }
    
    /**********/
    void update_selected()
    {
        JSONObject obj = loadJSONObject(selected_file);
            
        String deck_id = obj.getString("SelectedDeckId");
        
        selected = decks.get(deck_id);
    }
    
    /**********/
    void run() 
    {
        if( decks_ts != decks_file.lastModified() || selected_ts != selected_file.lastModified()) 
        {
            decks_ts = decks_file.lastModified();
            selected_ts = selected_file.lastModified();
            
            update_decks(); 
            update_selected();
            
            redraw();
        }
        
    }
}
