using System;

namespace GameLibModel
{
    public class BaseElement : ICloneable
    {
        public object Clone()
        {
            return this.MemberwiseClone();
        }
    }
}