using System;
using System.IO;
using System.Xml;
using System.Xml.Xsl;

namespace XMLOperationsLibrary
{
    public class XMLTransformator
    {
        public static string Transform(string xmlPath, string xsltPath)
        {
            XslCompiledTransform transform = new XslCompiledTransform();
            var xsltString = File.ReadAllText(xsltPath);
            var inputXml = File.ReadAllText(xmlPath);
            using (XmlReader reader = XmlReader.Create(new StringReader(xsltString)))
            {
                transform.Load(reader);
            }

            StringWriter results = new StringWriter();
            using (XmlReader reader = XmlReader.Create(new StringReader(inputXml)))
            {
                transform.Transform(reader, null, results);
            }


            return results.ToString();
        }
    }
}