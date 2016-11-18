<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReferencedSimpleExample.ascx.cs" Inherits="ReferencedUserControl.ReferencedSimpleExample" %>

<asp:TextBox ID="textColor" runat="server" 
    ReadOnly="True" />
<asp:Button Font-Bold="True" ID="buttonUp" runat="server" 
    Text="^" OnClick="buttonUp_Click" />
<asp:Button Font-Bold="True" ID="buttonDown" runat="server" 
    Text="v" OnClick="buttonDown_Click" />
