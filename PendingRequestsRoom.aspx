<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PendingRequestsRoom.aspx.cs" Inherits="library.PendingRequestsRoom" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Pending Room Reservations</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        .container {
            max-width: 900px;
            margin: 50px auto;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 20px;
        }
        .btn-approve {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-approve:hover {
            background-color: #218838;
        }
        .alert {
            text-align: center;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Pending Room Reservation Requests</h2>
            <asp:GridView ID="gvPendingRequests" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered" OnRowCommand="gvPendingRequests_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Room" HeaderText="Room" />
                    <asp:BoundField DataField="FullName" HeaderText="Name" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="ReservationDate" HeaderText="Date" />
                    <asp:BoundField DataField="ReservationTime" HeaderText="Time" />
                    <asp:BoundField DataField="SnackAndPrice" HeaderText="Snack" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnApprove" runat="server" Text="Approve" CssClass="btn-approve" CommandName="Approve" CommandArgument='<%# Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <hr/>

            <h2>Approved Room Reservations</h2>
            <asp:GridView ID="gvApprovedRequests" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered">
                <Columns>
                    <asp:BoundField DataField="Room" HeaderText="Room" />
                    <asp:BoundField DataField="FullName" HeaderText="Name" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="ReservationDate" HeaderText="Date" />
                    <asp:BoundField DataField="ReservationTime" HeaderText="Time" />
                    <asp:BoundField DataField="SnackAndPrice" HeaderText="Snack" />
                </Columns>
            </asp:GridView>

            <asp:Label ID="lblAdminMessage" runat="server" CssClass="alert text-danger mt-3"></asp:Label>
        </div>
    </form>
</body>
</html>
