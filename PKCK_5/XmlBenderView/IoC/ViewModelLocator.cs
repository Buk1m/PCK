using GalaSoft.MvvmLight.Ioc;
using Microsoft.Practices.ServiceLocation;
using XmlBenderView.EditorWindow.ViewModel;
using XmlBenderView.MainWindow.ViewModel;
using XmlBenderView.TransformationWindow.ViewModel;

namespace XmlBenderView.IoC
{
    public class ViewModelLocator
    {
        public ViewModelLocator()
        {
            ServiceLocator.SetLocatorProvider(() => SimpleIoc.Default);

            SimpleIoc.Default.Register<MainViewModel>();
            SimpleIoc.Default.Register<EditorViewModel>();
            SimpleIoc.Default.Register<FirstViewModel>();
        }

        public MainViewModel MainViewModel => ServiceLocator.Current.GetInstance<MainViewModel>();

        public EditorViewModel DataLoadingViewModel => ServiceLocator.Current.GetInstance<EditorViewModel>();

        public FirstViewModel FirstViewModel =>
            ServiceLocator.Current.GetInstance<FirstViewModel>();
    }
}