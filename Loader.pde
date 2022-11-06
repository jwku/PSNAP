Loader LOADER = null;

/**********/
class Loader extends Thread
{
    Object lock;
    boolean finished;

    Loader()
    {
        finished = false;
        lock = new Object();
    }

    boolean finished()
    {
        boolean f;

        synchronized(lock)
        {
            f = finished;
        }

        return f;
    }

    void run()
    {
        OPTIONS = new Options();  

        STAT = new Stat();

        CARDMANAGER = new CardManager();

        DECKMANAGER = new DeckManager();
            
        //ok, all loaded
        synchronized(lock)
        {
            //set flag
            finished = true;

            redraw();
        }
    }
}
