using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;

namespace GameLibModel
{
    public class GameLibrary
    {
        public GameLibrary()
        {
        }

        public GameLibrary(GameLibrary other)
        {
            Games = other.Games.Select(g => g.Clone() as Game).ToList();
            Players = other.Players.Select(p => p.Clone() as Player).ToList();
            Reviews = other.Reviews.Select(r => r.Clone() as Review).ToList();
            Authors = other.Authors.Select(a => a.Clone() as Author).ToList();
            Footer = other.Footer.Clone() as Footer;
        }

        public List<Game> Games { get; set; } = new List<Game>();
        public List<Player> Players { get; set; } = new List<Player>();
        public List<Review> Reviews { get; set; } = new List<Review>();
        public List<Author> Authors { get; set; } = new List<Author>();
        public Footer Footer { get; set; } = new Footer();
    }
}