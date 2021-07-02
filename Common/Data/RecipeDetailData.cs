using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common.Data
{
    public class RecipeDetailData
    {
        private int _recipeDetailID;
        public int RecipeDetailID
        {
            get { return _recipeDetailID; }
            set { _recipeDetailID = value; }
        }
        private int _recipeID;
        public int RecipeID
        {
            get { return _recipeID; }
            set { _recipeID = value; }
        }
        private string _recipeDetailIngredient;
        public string RecipeDetailIngredient
        {
            get { return _recipeDetailIngredient; }
            set { _recipeDetailIngredient = value; }
        }
        private int _recipeDetailQuantity;
        public int RecipeDetailQuantity
        {
            get { return _recipeDetailQuantity; }
            set { _recipeDetailQuantity = value; }
        }
        private string _recipeDetailUnit;
        public string RecipeDetailUnit
        {
            get { return _recipeDetailUnit; }
            set { _recipeDetailUnit = value; }
        }
    }
}
