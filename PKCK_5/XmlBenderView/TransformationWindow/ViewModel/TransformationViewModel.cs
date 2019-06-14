using System;
using System.IO;
using System.Text;
using System.Windows.Input;
using GalaSoft.MvvmLight;
using GalaSoft.MvvmLight.CommandWpf;
using SweetAlertSharp;
using SweetAlertSharp.Enums;
using XMLOperationsLibrary;
using OpenFileDialog = Microsoft.Win32.OpenFileDialog;

namespace XmlBenderView.TransformationWindow.ViewModel
{
    public class FirstViewModel : ViewModelBase
    {
        public ICommand TransformCommand => new RelayCommand(Transform);
        public ICommand ReadDocumentCommand => new RelayCommand(ReadDocument);
        public ICommand ReadTransformationCommand => new RelayCommand(ReadTransformation);
        public ICommand SaveTransformedDocumentCommand => new RelayCommand(SaveTransformation);

        public string XmlPath { get; set; }
        public string TransformationPath { get; set; }
        public string BaseDocument { get; set; }
        public string TransformedDocument { get; set; }
        public string XSLDocument { get; set; }

        private void Transform()
        {
            try
            {
                TransformedDocument = XMLTransformator.Transform(XmlPath, TransformationPath);
            }
            catch (Exception ex)
            {
                SweetAlert.Show("Error while transforming document:", ex.Message, msgImage: SweetAlertImage.ERROR);
            }
        }

        private string GetFileName(string extension)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog
            {
                InitialDirectory = "c:\\Users",
                Filter = $"(*.{extension})|*.{extension}|All files (*.*)|*.*",
                RestoreDirectory = true,
                CheckFileExists = false
            };

            bool? userClickedOK = openFileDialog.ShowDialog();

            return userClickedOK == true ? openFileDialog.FileName : null;
        }

        private void ReadDocument()
        {
            XmlPath = GetFileName("xml");
            if (XmlPath == null) return;
            try
            {
                var fileStream = new FileStream(XmlPath, FileMode.Open, FileAccess.Read);

                using (var streamReader = new StreamReader(fileStream, Encoding.UTF8))
                {
                    BaseDocument = streamReader.ReadToEnd();
                }
            }
            catch (IOException ex)
            {
                SweetAlert.Show("Error while reading document:", ex.Message, msgImage: SweetAlertImage.ERROR);
            }
        }

        private void ReadTransformation()
        {
            TransformationPath = GetFileName("xsl");
            if (TransformationPath == null) return;
            try
            {
                var fileStream = new FileStream(TransformationPath, FileMode.Open, FileAccess.Read);
                using (var streamReader = new StreamReader(fileStream, Encoding.UTF8))
                {
                    XSLDocument = streamReader.ReadToEnd();
                }
            }
            catch (IOException ex)
            {
                SweetAlert.Show("Error while reading transformation:", ex.Message, msgImage: SweetAlertImage.ERROR);
            }
        }

        private void SaveTransformation()
        {
            string savePath = GetFileName("");
            if (TransformationPath == null) return;
            try
            {
                if (!File.Exists(savePath))
                {
                    File.WriteAllText(savePath, TransformedDocument);
                }
            }
            catch (IOException ex)
            {
                SweetAlert.Show("Error while saving transformation:", ex.Message, msgImage: SweetAlertImage.ERROR);
            }
        }
    }
}