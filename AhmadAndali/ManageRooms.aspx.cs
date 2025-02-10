using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace library
{
    public partial class ManageRooms : Page
    {
        private string filePath = HttpContext.Current.Server.MapPath("~/App_Data/rooms.txt");
        private List<Room> filteredRooms = new List<Room>();

        public class Room
        {
            public string RoomID { get; set; }
            public string Name { get; set; }
            public string Status { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRooms();
            }

            // التحقق من حالة البوب أب عند PostBack
            if (ViewState["EditPopup"] != null && ViewState["EditPopup"].ToString() == "open" && Request.Form["__EVENTTARGET"]?.Contains("btnSaveChanges") == true)
            {
                popupEdit.Style["display"] = "block";
                overlay.Style["display"] = "block";
            }
            else
            {
                // منع ظهور البوب أب عند أي حدث آخر غير التعديل
                ViewState["EditPopup"] = null;
                popupEdit.Style["display"] = "none";
                overlay.Style["display"] = "none";
            }
        }
        

        private void LoadRooms(string filter = "all", string searchQuery = "")
        {
            if (!File.Exists(filePath))
            {
                File.Create(filePath).Close();
            }

            var rooms = File.ReadAllLines(filePath)
                            .Where(line => !string.IsNullOrWhiteSpace(line))
                            .Select(line => line.Split(','))
                            .Select(parts => new Room
                            {
                                RoomID = parts[0],
                                Name = parts[1],
                                Status = parts[2]
                            }).ToList();

            if (!string.IsNullOrEmpty(searchQuery))
            {
                rooms = rooms.Where(room => room.Name.ToLower().Contains(searchQuery.ToLower()) ||
                                            room.RoomID.ToLower().Contains(searchQuery.ToLower())).ToList();
            }

            if (filter == "available")
            {
                rooms = rooms.Where(room => room.Status == "available").ToList();
            }
            else if (filter == "reserved")
            {
                rooms = rooms.Where(room => room.Status == "reserved").ToList();
            }

            filteredRooms = rooms;
            gvRooms.DataSource = filteredRooms;
            gvRooms.DataBind();
        }

        protected void btnAddRoom_Click(object sender, EventArgs e)
        {
            if (File.Exists(filePath))
            {
                var lastLine = File.ReadLines(filePath).LastOrDefault();
                int nextId = lastLine != null ? int.Parse(lastLine.Split(',')[0]) + 1 : 1;

                string roomName = txtRoomName.Text.Trim();
                string status = "available";

                string newRoom = $"{nextId},{roomName},{status}";

                File.AppendAllText(filePath, newRoom + Environment.NewLine);


                // تنفيذ SweetAlert2 بعد نجاح الإضافة
                ClientScript.RegisterStartupScript(this.GetType(), "successAlert",
                    "Swal.fire({ title: 'Success!', text: 'Room added successfully!', icon: 'success', draggable: true });", true);
                LoadRooms();
            }
        }

        protected void btnRoomFilter_Click(object sender, EventArgs e)
        {
            string filter = ddlRoomFilter.SelectedValue;
            LoadRooms(filter);
        }

        protected void btnSearchRoom_Click(object sender, EventArgs e)
        {
            string searchQuery = txtRoomSearch.Text.Trim();
            LoadRooms("all", searchQuery);
        }

        protected void gvRooms_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string roomId = e.CommandArgument.ToString();

            if (e.CommandName == "DeleteRoom")
            {
                DeleteRoom(roomId);
            }
            else if (e.CommandName == "EditRoom")
            {
                LoadRoomForEdit(roomId);
            }
        }

        private void DeleteRoom(string roomId)
        {
            var rooms = File.ReadAllLines(filePath)
                            .Where(line => !line.StartsWith(roomId + ","))
                            .ToList();

            File.WriteAllLines(filePath, rooms);

            // تنفيذ SweetAlert2 بعد نجاح الإضافة
            ClientScript.RegisterStartupScript(this.GetType(), "successAlert",
                "Swal.fire({ title: 'Success!', text: 'Room Delete successfully!', icon: 'success', draggable: true });", true);
            LoadRooms();
        }

        private void LoadRoomForEdit(string roomId)
        {
            var room = File.ReadAllLines(filePath)
                           .Select(line => line.Split(','))
                           .Where(parts => parts[0] == roomId)
                           .Select(parts => new Room { RoomID = parts[0], Name = parts[1], Status = parts[2] })
                           .FirstOrDefault();

            if (room != null)
            {
                hfRoomID.Value = room.RoomID;
                txtEditRoomName.Text = room.Name;
                ddlEditRoomStatus.SelectedValue = room.Status;

                popupEdit.Style["display"] = "block";
                overlay.Style["display"] = "block";
            }
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            string roomId = hfRoomID.Value;
            string newName = txtEditRoomName.Text.Trim();
            string newStatus = ddlEditRoomStatus.SelectedValue;

            var rooms = File.ReadAllLines(filePath)
                            .Select(line => line.Split(','))
                            .Select(parts => parts[0] == roomId ? $"{roomId},{newName},{newStatus}" : string.Join(",", parts))
                            .ToList();

            File.WriteAllLines(filePath, rooms);
            // تنفيذ SweetAlert2 بعد نجاح الإضافة
            ClientScript.RegisterStartupScript(this.GetType(), "successAlert",
                "Swal.fire({ title: 'Success!', text: 'Room Edit successfully!', icon: 'success', draggable: true });", true);
            LoadRooms();

            popupEdit.Style["display"] = "none";
            overlay.Style["display"] = "none";
        }
    }
}
