namespace GameLibModel
{
    public class Review : BaseElement
    {
        public string GameId { get; set; }
        public string PlayerId { get; set; }
        public string Title { get; set; }
        public string Contents { get; set; }
        public double Score { get; set; }
        public int Day { get; set; }
        public int Month { get; set; }
        public int Year { get; set; }
    }
}