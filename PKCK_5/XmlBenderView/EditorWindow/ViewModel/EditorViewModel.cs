using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows.Input;
using System.Xml.Linq;
using System.Xml.Schema;
using GalaSoft.MvvmLight;
using GalaSoft.MvvmLight.CommandWpf;
using GameLibModel;
using Microsoft.Win32;
using SweetAlertSharp;
using SweetAlertSharp.Enums;
using XMLOperationsLibrary;

namespace XmlBenderView.EditorWindow.ViewModel
{
    public class EditorViewModel : ViewModelBase
    {
        private XMLDataHandler data;
        private string _schemaPath;

        private XDocument _generatedXDocument;
        private XDocument _baseDocument;
        public GameLibrary GameLibrary { get; set; } = new GameLibrary();
        private GameLibrary BaseGameLibrary { get; set; } = new GameLibrary();
        public ICommand ReadXmlCommand => new RelayCommand(ReadXml);
        public ICommand SaveXmlCommand => new RelayCommand(SaveXml);
        public ICommand ValidateXmlCommand => new RelayCommand(ValidateXml);
        public ICommand RestoreDocumentCommand => new RelayCommand(RestoreDocument);
        public ICommand UpdateIdsCommand => new RelayCommand(UpdateIds);

        private void UpdateIds()
        {
            Console.WriteLine("updating");
            GameIds =  new ObservableCollection<string>(GameLibrary.Games.Select(g => g.GameId).ToList());
            PlayerIds = new ObservableCollection<string>(GameLibrary.Players.Select(p => p.PlayerId).ToList());
            RaisePropertyChanged("GameIds");
            RaisePropertyChanged("PlayerIds");
        }


        public ObservableCollection<string> GameIds { get; set; }
        public ObservableCollection<string> PlayerIds { get; set; }

        private void SaveXml()
        {
            try
            {
                _generatedXDocument = data.CreateXDocument();
                data.SaveXML(_generatedXDocument, "BibliotekaGierAfter.xml");
            }
            catch (Exception ex)
            {
                SweetAlert.Show("Error while saving file:", ex.Message, msgImage: SweetAlertImage.ERROR);
            }
        }

        private void ReadXml()
        {
            data = new XMLDataHandler();
            string filename = GetFileName("xml");
            if (filename == null) return;
            try
            {
                _baseDocument = data.LoadXML(filename);
                _generatedXDocument = new XDocument(_baseDocument);
            }
            catch (Exception ex)
            {
                SweetAlert.Show("Error while reading file:", ex.Message, msgImage: SweetAlertImage.ERROR);
            }

            _schemaPath = GetFileName("xsd");
            try
            {
                XMLValidator.ValidateSchema("http://www.gamelib.org/types", _schemaPath, _baseDocument);
            }
            catch (Exception ex)
            {
                SweetAlert.Show("XSD Schema validation error:", ex.Message, msgImage: SweetAlertImage.ERROR);
            }

            GameLibrary = data.GameLibrary;
            BaseGameLibrary = new GameLibrary(GameLibrary);
            UpdateIds();
            RaisePropertyChanged("GamesIds");
        }

        private void ValidateXml()
        {
            if (null == data.GameLibrary) return;

            try
            {
                _generatedXDocument = data.CreateXDocument();
                _schemaPath = GetFileName("xsd");
                XMLValidator.ValidateSchema("http://www.gamelib.org/types", _schemaPath, _generatedXDocument);
            }
            catch (XmlSchemaValidationException ex)
            {
                SweetAlert.Show("XSD Schema validation error:", ex.Message, msgImage: SweetAlertImage.ERROR);
            }
            catch (Exception ex)
            {
                SweetAlert.Show("Model error:", ex.Message, msgImage: SweetAlertImage.ERROR);
            }
        }

        private string GetFileName(string extension)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog
            {
                InitialDirectory = "c:\\",
                Filter = $"(*.{extension})|*.{extension}|All files (*.*)|*.*",
                RestoreDirectory = true,
                CheckFileExists = false
            };

            bool? userClickedOK = openFileDialog.ShowDialog();

            return userClickedOK == true ? openFileDialog.FileName : null;
        }

        private void RestoreDocument()
        {
            if (_baseDocument == null)
            {
                SweetAlert.Show("Restoring error", "Read xml document first.", msgImage: SweetAlertImage.ERROR);
                return;
            }

            GameLibrary = new GameLibrary(BaseGameLibrary);
            data.GameLibrary = GameLibrary;
            _generatedXDocument = new XDocument(_baseDocument);
            ;
            RaisePropertyChanged("GameLibrary");
        }

        #region privates

        #endregion
    }
}