using Common.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SystemFramework;

namespace DataAccess
{
    public class RecipeDetailDB
    {
        public List<RecipeDetailData> GetRecipeDetailList(int recipeID)
        {
            try
            {
                string SpName = "dbo.RecipeDetail_Get";
                List<RecipeDetailData> ListRecipeDetail = new List<RecipeDetailData>();
                using (SqlConnection SqlConn = new SqlConnection())
                {
                    SqlConn.ConnectionString = SystemConfigurations.EateryConnectionString;
                    SqlConn.Open();
                    SqlCommand SqlCmd = new SqlCommand(SpName, SqlConn);
                    SqlCmd.CommandType = CommandType.StoredProcedure;
                    SqlCmd.Parameters.Add(new SqlParameter("@RecipeID", recipeID));
                    using (SqlDataReader Reader = SqlCmd.ExecuteReader())
                    {
                        if (Reader.HasRows)
                        {
                            while (Reader.Read())
                            {
                                RecipeDetailData recipeDetail = new RecipeDetailData();
                                recipeDetail.RecipeDetailID = Convert.ToInt32(Reader["RecipeDetailID"]);
                                recipeDetail.RecipeID = Convert.ToInt32(Reader["RecipeID"]);
                                recipeDetail.RecipeDetailIngredient = Convert.ToString(Reader["RecipeDetailIngredient"]);
                                recipeDetail.RecipeDetailQuantity = Convert.ToInt32(Reader["RecipeDetailQuantity"]);
                                recipeDetail.RecipeDetailUnit = Convert.ToString(Reader["RecipeDetailUnit"]);
                                ListRecipeDetail.Add(recipeDetail);
                            }
                        }
                    }
                    SqlConn.Close();
                }
                return ListRecipeDetail;
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
                string SpName = "dbo.RecipeDetail_GetByID";
                RecipeDetailData recipeDetail = null;
                using (SqlConnection SqlConn = new SqlConnection())
                {
                    SqlConn.ConnectionString = SystemConfigurations.EateryConnectionString;
                    SqlConn.Open();
                    SqlCommand SqlCmd = new SqlCommand(SpName, SqlConn);
                    SqlCmd.CommandType = CommandType.StoredProcedure;
                    SqlCmd.Parameters.Add(new SqlParameter("@RecipeDetailID", recipeDetailID));
                    using (SqlDataReader Reader = SqlCmd.ExecuteReader())
                    {
                        if (Reader.HasRows)
                        {
                            Reader.Read();
                            recipeDetail = new RecipeDetailData();
                            recipeDetail.RecipeDetailID = Convert.ToInt32(Reader["RecipeDetailID"]);
                            recipeDetail.RecipeID = Convert.ToInt32(Reader["RecipeID"]);
                            recipeDetail.RecipeDetailIngredient = Convert.ToString(Reader["RecipeDetailIngredient"]);
                            recipeDetail.RecipeDetailQuantity = Convert.ToInt32(Reader["RecipeDetailQuantity"]);
                            recipeDetail.RecipeDetailUnit = Convert.ToString(Reader["RecipeDetailUnit"]);
                        }
                    }
                    SqlConn.Close();
                }
                return recipeDetail;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public int InsertUpdateRecipeDetail(RecipeDetailData recipeDetail, SqlTransaction SqlTran)
        {
            try
            {
                string SpName = "dbo.RecipeDetail_InsertUpdate";
                SqlCommand SqlCmd = new SqlCommand(SpName, SqlTran.Connection, SqlTran);
                SqlCmd.CommandType = CommandType.StoredProcedure;

                SqlParameter RecipeDetailId = new SqlParameter("@RecipeDetailID", recipeDetail.RecipeDetailID);
                RecipeDetailId.Direction = ParameterDirection.InputOutput;
                SqlCmd.Parameters.Add(RecipeDetailId);

                SqlCmd.Parameters.Add(new SqlParameter("@RecipeID", recipeDetail.RecipeID));
                SqlCmd.Parameters.Add(new SqlParameter("@RecipeDetailIngredient", recipeDetail.RecipeDetailIngredient));
                SqlCmd.Parameters.Add(new SqlParameter("@RecipeDetailQuantity", recipeDetail.RecipeDetailQuantity));
                SqlCmd.Parameters.Add(new SqlParameter("@RecipeDetailUnit", recipeDetail.RecipeDetailUnit));
                return SqlCmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public int DeleteRecipeDetails(string recipeDetailIDs, SqlTransaction SqlTran)
        {
            try
            {
                string SpName = "dbo.RecipeDetail_Delete";
                SqlCommand SqlCmd = new SqlCommand(SpName, SqlTran.Connection, SqlTran);
                SqlCmd.CommandType = CommandType.StoredProcedure;
                SqlCmd.Parameters.Add(new SqlParameter("@RecipeDetailIDs", recipeDetailIDs));
                return SqlCmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
