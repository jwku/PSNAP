public static final String PROFILE_FILE = "ProfileState.json";

/**********/
class Stat extends TimerTask 
{ 
    File file;
    long ts;
    
    int rank;
    int victory;
    int defeat;
    
    int streak;
    float rate;
    
    java.util.Timer timer;
    
    /**********/
    Stat()
    {
        file = new File(OPTIONS.path + PROFILE_FILE);
        
        ts = file.lastModified();
     
        update();
        
        timer = new java.util.Timer();
    
        timer.schedule( this, new Date(), 1000 );
    }
      
    /**********/
    void update()
    {

        JSONObject obj = loadJSONObject(file);
            
        JSONObject serverstate = obj.getJSONObject("ServerState");
            
        JSONObject ranklog = serverstate.getJSONObject("RankLog");
            
        rank = ranklog.getInt("Rank");
            
        JSONObject account = serverstate.getJSONObject("Account"); 
    
        victory = account.getInt("WinsInPlaytestEnvironment");
        defeat = account.getInt("LossesInPlaytestEnvironment");
            
        JSONObject matchhistory = serverstate.getJSONObject("MatchHistory");
            
        JSONArray historyleague = matchhistory.getJSONArray("HistoryPerLeague");
            
        JSONObject recentgames = historyleague.getJSONObject(0);
            
        streak = recentgames.getInt("WinningStreak");
        streak = (streak < 0) ? 0 : streak;
            
        rate = (float)recentgames.getFloat("RecentWinRate");
        
    }
    
    /**********/
    String getGeneralString()
    {
        String s = "OVERALL\n";
        
        s += "Rank : " + rank + "\n";
        s += "Victories : " + victory + "\n";
        s += "Defeats : " + defeat;
        
        return s;
    }
    
    String getRecentString()
    {
        String s = "RECENT GAMES\n";
        s += "Win Streak : " + streak + "\n";
        s += "Win Rate : " + String.format("%d",(int)(rate*100)) + "%";

        return s;
    }

    /**********/
    void run() 
    {
        if( ts != file.lastModified() ) 
        {
            ts = file.lastModified();
            
            //update and redraw
            update();

            redraw();
        }
    }
}
