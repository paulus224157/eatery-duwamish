using BusinessRule;
using Common.Data;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessFacade
{
    public class RecipeDetailSystem
    {
        public List<RecipeDetailData> GetRecipeDetailList(int recipeID)
        {
            try
            {
                return new RecipeDetailDB().GetRecipeDetailList(recipeID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public RecipeDetailData GetRecipeDetailByID(int recipeDetailID)
        {
            try
            {
                return new RecipeDetailDB().GetRecipeDetailByID(recipeDetailID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public int InsertUpdateRecipeDetail(RecipeDetailData recipeDetail)
        {
            try
            {
                return new RecipeDetailRule().InsertUpdateRecipeDetail(recipeDetail);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public int DeleteRecipeDetails(IEnumerable<int> recipeDetailIDs)
        {
            try
            {
                return new RecipeDetailRule().DeleteRecipeDetails(recipeDetailIDs);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
