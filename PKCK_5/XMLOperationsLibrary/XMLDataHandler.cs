using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Xml.Linq;
using GameLibModel;

namespace XMLOperationsLibrary
{
    public class XMLDataHandler
    {
        public GameLibrary GameLibrary { get; set; } = new GameLibrary();
        XNamespace ns = "http://www.gamelib.org/types";

        public XDocument LoadXML(string path)
        {
            XDocument xDocument = XDocument.Load(path);
            List<Game> games = new List<Game>();
            List<Review> reviews = new List<Review>();

            foreach (var element in xDocument.Root.Descendants(ns + "ListaGier").Descendants(ns + "Gra"))
            {
                string title = element.Element(ns + "Tytul").Value;
                string publisher = element.Element(ns + "Wydawca").Value;
                string producer = element.Element(ns + "Producent").Value;
                string cena = element.Element(ns + "Cena").Value;
                Double.TryParse(cena, NumberStyles.Number, CultureInfo.CreateSpecificCulture("en-GB"),
                    out double price);
                string descrption = element.Element(ns + "Opis")?.Value;
                Double.TryParse(element.Element(ns + "OcenaKrytyka").Value, NumberStyles.Number,
                    CultureInfo.CreateSpecificCulture("en-GB"), out double score);
                string gameId = element.Attribute("IdGry").Value;
                Int32.TryParse(element.Attribute("RokWydania").Value, out int publishDate);
                Enum.TryParse(element.Attribute("Gatunek").Value, out Genre genre);
                Enum.TryParse(element.Attribute("Platforma").Value, out Platform platform);
                Enum.TryParse(element.Attribute("PEGI")?.Value, out PEGI pegi);


                var game =
                    new Game()
                    {
                        Description = descrption,
                        GameId = gameId,
                        Genre = genre,
                        Title = title,
                        PublishDate = publishDate,
                        Publisher = publisher,
                        Score = score,
                        Platform = platform,
                        Price = price,
                        Producer = producer,
                        Pegi = pegi
                    };

                GameLibrary.Games.Add(game);
            }

            foreach (var element in xDocument.Root.Descendants(ns + "Recenzje").Descendants(ns + "Recenzja"))
            {
                string title = element.Element(ns + "Tytul").Value;
                string content = element.Element(ns + "TrescRecenzji").Value;
                XElement reviewDate = element.Element(ns + "DataRecenzji");
                string gameId = element.Attribute("IdGry").Value;
                string playerId = element.Attribute("IdGracza").Value;
                Double.TryParse(element.Element("Ocena")?.Attribute("Wartość").Value, out double score);

                var review =
                    new Review()
                    {
                        GameId = gameId,
                        PlayerId = playerId,
                        Title = title,
                        Score = score,
                        Contents = content
                    };

                GameLibrary.Reviews.Add(review);
            }

            foreach (var element in xDocument.Root.Descendants(ns + "Gracze").Descendants(ns + "Gracz"))
            {
                string name = element.Element(ns + "Imie").Value;
                string nick = element.Element(ns + "PseudonimGracza").Value;
                string playerId = element.Attribute("IdGracza").Value;


                var player =
                    new Player()
                    {
                        Name = name,
                        Nick = nick,
                        PlayerId = playerId
                    };

                GameLibrary.Players.Add(player);
            }

            foreach (var element in xDocument.Root.Descendants(ns + "AutorzyDokumentu").Descendants(ns + "Autor"))
            {
                string firstName = element.Element(ns + "Imie").Value;
                string lastName = element.Element(ns + "Nazwisko").Value;
                string index = element.Element(ns + "NumerIndeksu").Value;


                var author =
                    new Author()
                    {
                        FirstName = firstName,
                        LastName = lastName,
                        IndexNumber = index
                    };

                GameLibrary.Authors.Add(author);
            }

            var footer = xDocument.Root.Descendants(ns + "Stopka");
            foreach (var element in footer)
            {
                GameLibrary.Footer.LastEdit = element.Element(ns + "OstatniaEdycja").Attribute("Data").Value;
            }

            return xDocument;
        }

        public XDocument CreateXDocument()
        {
            var games = GameLibrary.Games.Select(game => new XElement(ns + "Gra",
                new XAttribute("IdGry", game.GameId),
                new XAttribute("RokWydania", game.PublishDate),
                new XAttribute("Gatunek", game.Genre),
                new XAttribute("Platforma", game.Platform),
                new XElement(ns + "Tytul", game.Title),
                new XElement(ns + "Wydawca", game.Publisher),
                new XElement(ns + "Producent", game.Producer),
                new XElement(ns + "Cena", game.Price),
                game.Description != null ? new XElement(ns + "Opis", game.Description) : null,
                new XElement(ns + "OcenaKrytyka", game.Score))
            ).ToArray();

            var players = GameLibrary.Players.Select(player => new XElement(ns + "Gracz",
                new XAttribute("IdGracza", player.PlayerId),
                new XElement(ns + "Imie", player.Name),
                new XElement(ns + "PseudonimGracza", player.Nick))
            ).ToArray();


            var reviews = GameLibrary.Reviews.Select(review => new XElement(ns + "Recenzja",
                    new XAttribute("IdGry", review.GameId),
                    new XAttribute("IdGracza", review.PlayerId),
                    new XElement(ns + "Tytul", review.Title),
                    new XElement(ns + "TrescRecenzji", review.Contents),
                    new XElement(ns + "DataRecenzji", new XAttribute("Dzien", review.Day),
                        new XAttribute("Miesiac", review.Month), new XAttribute("Rok", review.Year)),
                    new XElement(ns + "Ocena", new XAttribute("Wartosc", review.Score))
                )
            ).ToArray();

            var authors = GameLibrary.Authors.Select(author => new XElement(ns + "Autor",
                new XElement(ns + "Imie", author.FirstName),
                new XElement(ns + "Nazwisko", author.LastName),
                new XElement(ns + "NumerIndeksu", author.IndexNumber))
            ).ToArray();

            var footer = new XElement(ns + "Stopka",
                new XElement(ns + "OstatniaEdycja", new XAttribute("Data", GameLibrary.Footer.LastEdit)),
                new XElement(ns+"Logo")
            );

            var gamesElement = new XElement(ns + "ListaGier", games);
            var playersElement = new XElement(ns + "Gracze", players);
            var reviewElement = new XElement(ns + "Recenzje", reviews);
            var authorsElement = new XElement(ns + "AutorzyDokumentu", authors);

            var root = new XElement(ns + "BibliotekaGier",
                new XAttribute("xmlns", ns),
                new XAttribute(XNamespace.Xmlns + "xsd", "http://www.w3.org/2001/XMLSchema"),
                authorsElement,
                gamesElement,
                playersElement,
                reviewElement,
                footer);
            var doc = new XDocument(new XDeclaration("1.0", "UTF-8", null), root);
            return doc;
        }

        public void SaveXML(XDocument doc, string path)
        {
            doc.Save(path);
        }
    }
}