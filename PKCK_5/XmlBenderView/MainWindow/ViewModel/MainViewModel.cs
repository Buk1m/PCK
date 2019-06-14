using System.Windows.Input;
using GalaSoft.MvvmLight;
using GalaSoft.MvvmLight.CommandWpf;
using GalaSoft.MvvmLight.Ioc;
using XmlBenderView.EditorWindow.ViewModel;
using XmlBenderView.TransformationWindow.ViewModel;

namespace XmlBenderView.MainWindow.ViewModel
{
    public class MainViewModel : ViewModelBase
    {
        public ICommand ShowTransformerView { get; set; }
        public ICommand ShowEditorView { get; set; }

        private ViewModelBase _currentViewModel;
        private FirstViewModel _firstViewModel;
        private EditorViewModel _editorViewModel;

        public ViewModelBase CurrentViewModel
        {
            get => _currentViewModel;
            set
            {
                if (_currentViewModel == value)
                    return;
                _currentViewModel = value;
                RaisePropertyChanged("CurrentViewModel");
            }
        }

        public MainViewModel()
        {
            _editorViewModel = SimpleIoc.Default.GetInstance<EditorViewModel>();
            _firstViewModel = SimpleIoc.Default.GetInstance<FirstViewModel>();
            CurrentViewModel = _editorViewModel;
            ShowTransformerView = new RelayCommand(ChangeViewToTransformation);
            ShowEditorView = new RelayCommand(ChangeViewToEditor);
        }

        private void ChangeViewToTransformation()
        {
            CurrentViewModel = _firstViewModel;
        }

        private void ChangeViewToEditor()
        {
            CurrentViewModel = _editorViewModel;
        }
    }
}