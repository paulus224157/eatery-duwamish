using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common.Data
{
    public class RecipeDescriptionData
    {
        private int _recipeDescriptionID;
        public int RecipeDescriptionID
        {
            get { return _recipeDescriptionID; }
            set { _recipeDescriptionID = value; }
        }
        private int _recipeID;
        public int RecipeID
        {
            get { return _recipeID; }
            set { _recipeID = value; }
        }
        private string _recipeDescriptionMessage;
        public string RecipeDescriptionMessage
        {
            get { return _recipeDescriptionMessage; }
            set { _recipeDescriptionMessage = value; }
        }
    }
}
