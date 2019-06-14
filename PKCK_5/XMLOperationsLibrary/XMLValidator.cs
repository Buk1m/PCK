using System.Xml.Linq;
using System.Xml.Schema;

namespace XMLOperationsLibrary
{
    public class XMLValidator
    {
        public static void ValidateSchema(string namespaceName, string schemaPath, XDocument xmlDocument)
        {
            XmlSchemaSet schemas = new XmlSchemaSet();
            schemas.Add(namespaceName, schemaPath);
            xmlDocument.Validate(schemas, null);
        }
    }
}