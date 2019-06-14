namespace GameLibModel
{
    public class Game : BaseElement
    {
        public string GameId { get; set; }
        public int PublishDate { get; set; }
        public Genre Genre { get; set; }
        public Platform Platform { get; set; }
        public string Title { get; set; }
        public string Producer { get; set; }
        public string Publisher { get; set; }
        public double Price { get; set; }
        public string Description { get; set; }
        public double Score { get; set; }
        public PEGI Pegi { get; set; }
    }

    public enum PEGI
    {
        PEGI3=3,
        PEGI7=7,
        PEGI12=12,
        PEGI16=16,
        PEGI18=18
    }

    public enum Platform
    {
        PC,
        PS4,
        PS3,
        PS2,
        PSP,
        X360,
        XONE,
        Nintendo,
        DS, //check if this is a problem
        Switch,
    }

    public enum Genre
    {
        Bijatyki,
        Akcji,
        FPS,
        Horror,
        Survival,
        Zrecznosciowe,
        Strategiczne,
        RPG,
        Przygodowe,
        Platformowki,
        Sportowe,
        Wyscigi,
        Symulacje,
        Logiczne,
        MMO,
    }
}