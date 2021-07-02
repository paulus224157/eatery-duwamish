using BusinessFacade;
using Common.Data;
using Common.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EateryDuwamish
{
    public partial class Detail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int recipeID = Convert.ToInt32(Request.QueryString["id"]);
            ShowNotificationIfExists();
            LoadRecipeDetailTable(recipeID);
            LoadRecipeDescription(recipeID);
        }

        #region FORM MANAGEMENT
        private void FillForm(RecipeDetailData recipeDetail)
        {
            hdfRecipeDetailId.Value = recipeDetail.RecipeDetailID.ToString();
            txtRecipeDetailIngredient.Text = recipeDetail.RecipeDetailIngredient;
            txtRecipeDetailQuantity.Text = recipeDetail.RecipeDetailQuantity.ToString();
            txtRecipeDetailUnit.Text = recipeDetail.RecipeDetailUnit;
        }
        private void ResetForm()
        {
            hdfRecipeDetailId.Value = String.Empty;
            txtRecipeDetailIngredient.Text = String.Empty;
            txtRecipeDetailQuantity.Text = String.Empty;
            txtRecipeDetailUnit.Text = String.Empty;
        }
        private RecipeDetailData GetFormData()
        {
            RecipeDetailData recipeDetail = new RecipeDetailData();
            recipeDetail.RecipeDetailID = String.IsNullOrEmpty(hdfRecipeDetailId.Value) ? 0 : Convert.ToInt32(hdfRecipeDetailId.Value);
            recipeDetail.RecipeDetailIngredient = txtRecipeDetailIngredient.Text;
            recipeDetail.RecipeDetailQuantity = Convert.ToInt32(txtRecipeDetailQuantity.Text);
            recipeDetail.RecipeDetailUnit = txtRecipeDetailUnit.Text;

            int recipeID = Convert.ToInt32(Request.QueryString["id"]);
            recipeDetail.RecipeID = recipeID;
            return recipeDetail;
        }
        #endregion

        #region DATA TABLE MANAGEMENT
        private void LoadRecipeDetailTable(int recipeID)
        {
            try
            {
                RecipeData RecipeName = new RecipeSystem().GetRecipeByID(recipeID);
                litPageTitle.Text = $"{RecipeName.RecipeName}";

                List<RecipeDetailData> ListRecipeDetail = new RecipeDetailSystem().GetRecipeDetailList(recipeID);
                rptRecipeDetail.DataSource = ListRecipeDetail;
                rptRecipeDetail.DataBind();
            }
            catch (Exception ex)
            {
                notifRecipeDetail.Show($"ERROR LOAD TABLE: {ex.Message}", NotificationType.Danger);
            }
        }
        private void LoadRecipeDescription(int recipeID)
        {
            try
            {
                RecipeDescriptionData recipeDescription = new RecipeDescriptionSystem().GetRecipeDescriptionMessage(recipeID);
                if (recipeDescription == null)
                {
                    txtRecipeDescription.Text = String.Empty;
                    hdfRecipeDescriptionId.Value = "0";
                }
                else
                {
                txtRecipeDescription.Text = String.IsNullOrEmpty(recipeDescription.RecipeDescriptionMessage) ? String.Empty : recipeDescription.RecipeDescriptionMessage;
                hdfRecipeDescriptionId.Value = String.IsNullOrEmpty(recipeDescription.RecipeDescriptionID.ToString()) ? "0" : recipeDescription.RecipeDescriptionID.ToString();
                }
                
            }
            catch (Exception ex)
            {
                notifRecipeDetail.Show($"ERROR LOAD TABLE: {ex.Message}", NotificationType.Danger);
            }
        }
        protected void rptRecipeDetail_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                RecipeDetailData recipeDetail = (RecipeDetailData)e.Item.DataItem;
                Literal litRecipeDetailIngredient = (Literal)e.Item.FindControl("litRecipeDetailIngredient");
                Literal litRecipeDetailQuantity = (Literal)e.Item.FindControl("litRecipeDetailQuantity");
                Literal litRecipeDetailUnit = (Literal)e.Item.FindControl("litRecipeDetailUnit");
                LinkButton lbEditRecipeDetail = (LinkButton)e.Item.FindControl("lbEditRecipeDetail");

                litRecipeDetailIngredient.Text = recipeDetail.RecipeDetailIngredient;
                litRecipeDetailQuantity.Text = recipeDetail.RecipeDetailQuantity.ToString();
                litRecipeDetailUnit.Text = recipeDetail.RecipeDetailUnit;

                CheckBox chkChoose = (CheckBox)e.Item.FindControl("chkChoose");
                chkChoose.Attributes.Add("data-value", recipeDetail.RecipeDetailID.ToString());

                lbEditRecipeDetail.CommandArgument = recipeDetail.RecipeDetailID.ToString();
            }
        }
        protected void rptRecipeDetail_ItemCommand(object sender, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "EDIT")
            {
                Literal litRecipeDetailIngredient = (Literal)e.Item.FindControl("litRecipeDetailIngredient");
                Literal litRecipeDetailQuantity = (Literal)e.Item.FindControl("litRecipeDetailQuantity");
                Literal litRecipeDetailUnit = (Literal)e.Item.FindControl("litRecipeDetailUnit");

                int recipeDetailID = Convert.ToInt32(e.CommandArgument.ToString());
                RecipeDetailData recipeDetail = new RecipeDetailSystem().GetRecipeDetailByID(recipeDetailID);
                FillForm(new RecipeDetailData
                {
                    RecipeDetailID = recipeDetail.RecipeDetailID,
                    RecipeDetailIngredient = recipeDetail.RecipeDetailIngredient,
                    RecipeDetailQuantity = recipeDetail.RecipeDetailQuantity,
                    RecipeDetailUnit = recipeDetail.RecipeDetailUnit
                });
                litFormType.Text = $"UBAH: {litRecipeDetailIngredient.Text}";
                pnlFormRecipeDetail.Visible = true;
                txtRecipeDetailIngredient.Focus();
            }
        }
        #endregion

        #region BUTTON EVENT MANAGEMENT
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                RecipeDetailData recipeDetail = GetFormData();
                int rowAffected = new RecipeDetailSystem().InsertUpdateRecipeDetail(recipeDetail);
                if (rowAffected <= 0)
                    throw new Exception("No Data Recorded");
                Session["save-success"] = 1;
                Response.Redirect("Detail.aspx?id=" + recipeDetail.RecipeID.ToString());
            }
            catch (Exception ex)
            {
                notifRecipeDetail.Show($"ERROR SAVE DATA: {ex.Message}", NotificationType.Danger);
            }
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            ResetForm();
            litFormType.Text = "TAMBAH";
            pnlFormRecipeDetail.Visible = true;
            txtRecipeDetailIngredient.Focus();
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                string strDeletedIDs = hdfDeletedRecipeDetails.Value;
                int recipeID = Convert.ToInt32(Request.QueryString["id"]);
                IEnumerable<int> deletedIDs = strDeletedIDs.Split(',').Select(Int32.Parse);
                int rowAffected = new RecipeDetailSystem().DeleteRecipeDetails(deletedIDs);
                if (rowAffected <= 0)
                    throw new Exception("No Data Deleted");
                Session["delete-success"] = 1;
                Response.Redirect("Detail.aspx?id=" + recipeID);
            }
            catch (Exception ex)
            {
                notifRecipeDetail.Show($"ERROR DELETE DATA: {ex.Message}", NotificationType.Danger);
            }
        }
        protected void btnEditDescription_Click(object sender, EventArgs e)
        {
            txtRecipeDescription.ReadOnly = false;
        }
        protected void btnSaveDescription_Click(object sender, EventArgs e)
        {
            txtRecipeDescription.ReadOnly = true;
            try
            {
                int recipeID = Convert.ToInt32(Request.QueryString["id"]);

                RecipeDescriptionData recipeDescription = new RecipeDescriptionData();
                recipeDescription.RecipeDescriptionID = Convert.ToInt32(hdfRecipeDescriptionId.Value);
                recipeDescription.RecipeID = recipeID;
                recipeDescription.RecipeDescriptionMessage = Request.Form[txtRecipeDescription.UniqueID];

                int rowAffected = new RecipeDescriptionSystem().InsertUpdateRecipeDescription(recipeDescription);
                if (rowAffected <= 0)
                    throw new Exception("No Data Recorded");
                Session["save-success"] = 1;
                Response.Redirect("Detail.aspx?id=" + recipeID);
            }
            catch (Exception ex)
            {
                notifRecipeDetail.Show($"ERROR SAVE DATA: {ex.Message}", NotificationType.Danger);
            }
        }
        #endregion

        #region NOTIFICATION MANAGEMENT
        private void ShowNotificationIfExists()
        {
            if (Session["save-success"] != null)
            {
                notifRecipeDetail.Show("Data sukses disimpan", NotificationType.Success);
                Session.Remove("save-success");
            }
            if (Session["delete-success"] != null)
            {
                notifRecipeDetail.Show("Data sukses dihapus", NotificationType.Success);
                Session.Remove("delete-success");
            }
        }
        #endregion
    }
}