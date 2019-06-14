using System;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
using System.Windows.Media.Animation;

namespace XmlBenderView.MainWindow.View
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        #region Sidebar Animations

        private bool animationCompleted;
        private bool mouseInside;

        private async void method()
        {
            for (int i = 0; i < 5; i++)
            {
                await Task.Delay(100);
                if (!Sidebar.IsMouseOver)
                {
                    mouseInside = false;
                    return;
                }
            }

            if (mouseInside)
            {
                DoubleAnimation slideOut = new DoubleAnimation
                {
                    To = 230,
                    Duration = TimeSpan.FromSeconds(0.6),
                    DecelerationRatio = 0.9
                };
                slideOut.Completed += (s, ev) => { animationCompleted = true; };
                slideOut.Completed += hideSidebar;
                await Dispatcher.BeginInvoke(
                    new Action(() => Sidebar.BeginAnimation(WidthProperty, slideOut)));
            }
        }

        private async void Sidebar_OnMouseEnter(object sender, MouseEventArgs e)
        {
            mouseInside = true;
            await Dispatcher.BeginInvoke(new ThreadStart(() => method()));
        }


        private void Sidebar_OnMouseLeave(object sender, MouseEventArgs e)
        {
            mouseInside = false;
            if (animationCompleted)
            {
                DoubleAnimation slideOut = new DoubleAnimation
                {
                    To = 50,
                    Duration = TimeSpan.FromSeconds(0.6),
                    DecelerationRatio = 0.9
                };

                Sidebar.BeginAnimation(WidthProperty, slideOut);
                animationCompleted = false;
            }
        }

        void hideSidebar(object sender, EventArgs e)
        {
            if (!mouseInside)
            {
                DoubleAnimation slideOut = new DoubleAnimation
                {
                    To = 50,
                    Duration = TimeSpan.FromSeconds(1),
                    DecelerationRatio = 0.9
                };
                Sidebar.BeginAnimation(WidthProperty, slideOut);
                animationCompleted = false;
            }
        }

        #endregion

    }
}
