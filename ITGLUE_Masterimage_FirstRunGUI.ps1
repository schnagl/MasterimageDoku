$FormFirstRun = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Control]$Control1 = $null
[System.Windows.Forms.Control]$Control2 = $null
[System.Windows.Forms.PictureBox]$PictureBoxFirstRun = $null
[System.Windows.Forms.Label]$Label1 = $null
[System.Windows.Forms.Control]$Control3 = $null
[System.Windows.Forms.Control]$Control4 = $null
[System.Windows.Forms.Button]$ButtonSave = $null
[System.Windows.Forms.Button]$ButtonCancel = $null
[System.Windows.Forms.Label]$Label8 = $null
[System.Windows.Forms.Control]$Control5 = $null
[System.Windows.Forms.Label]$Label3 = $null
[System.Windows.Forms.TableLayoutPanel]$TableLayoutPanel1 = $null
[System.Windows.Forms.TextBox]$TextBoxOrgID = $null
[System.Windows.Forms.Label]$Label5 = $null
[System.Windows.Forms.Label]$LabelWebhook = $null
[System.Windows.Forms.TextBox]$TextBoxWebhook = $null
[System.Windows.Forms.Label]$Label2 = $null
[System.Windows.Forms.RichTextBox]$RichTextBoxCustomerInput = $null
[System.Windows.Forms.Label]$Label4 = $null
[System.Windows.Forms.Label]$Label6 = $null
[System.Windows.Forms.Label]$Label9 = $null
[System.Windows.Forms.Label]$Label7 = $null
function InitializeComponent
{
$Control1 = (New-Object -TypeName System.Windows.Forms.Control)
$Control2 = (New-Object -TypeName System.Windows.Forms.Control)
$PictureBoxFirstRun = (New-Object -TypeName System.Windows.Forms.PictureBox)
$Label1 = (New-Object -TypeName System.Windows.Forms.Label)
$Control3 = (New-Object -TypeName System.Windows.Forms.Control)
$Control4 = (New-Object -TypeName System.Windows.Forms.Control)
$ButtonSave = (New-Object -TypeName System.Windows.Forms.Button)
$ButtonCancel = (New-Object -TypeName System.Windows.Forms.Button)
$Label8 = (New-Object -TypeName System.Windows.Forms.Label)
$Control5 = (New-Object -TypeName System.Windows.Forms.Control)
$Label3 = (New-Object -TypeName System.Windows.Forms.Label)
$TableLayoutPanel1 = (New-Object -TypeName System.Windows.Forms.TableLayoutPanel)
$TextBoxOrgID = (New-Object -TypeName System.Windows.Forms.TextBox)
$Label5 = (New-Object -TypeName System.Windows.Forms.Label)
$LabelWebhook = (New-Object -TypeName System.Windows.Forms.Label)
$TextBoxWebhook = (New-Object -TypeName System.Windows.Forms.TextBox)
$Label2 = (New-Object -TypeName System.Windows.Forms.Label)
$RichTextBoxCustomerInput = (New-Object -TypeName System.Windows.Forms.RichTextBox)
$Label4 = (New-Object -TypeName System.Windows.Forms.Label)
$Label6 = (New-Object -TypeName System.Windows.Forms.Label)
$Label9 = (New-Object -TypeName System.Windows.Forms.Label)
$Label7 = (New-Object -TypeName System.Windows.Forms.Label)
([System.ComponentModel.ISupportInitialize]$PictureBoxFirstRun).BeginInit()
$TableLayoutPanel1.SuspendLayout()
$FormFirstRun.SuspendLayout()
#
#Control1
#
$Control1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]10,[System.Int32]10))
$Control1.Name = [System.String]'Control1'
$Control1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]0,[System.Int32]0))
$Control1.TabIndex = [System.Int32]1
#
#Control2
#
$Control2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]10,[System.Int32]10))
$Control2.Name = [System.String]'Control2'
$Control2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]0,[System.Int32]0))
$Control2.TabIndex = [System.Int32]2
#
#PictureBoxFirstRun
#
$PictureBoxFirstRun.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]356,[System.Int32]26))
$PictureBoxFirstRun.Name = [System.String]'PictureBoxFirstRun'
$PictureBoxFirstRun.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]374,[System.Int32]120))
$PictureBoxFirstRun.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::Zoom
$PictureBoxFirstRun.TabIndex = [System.Int32]3
$PictureBoxFirstRun.TabStop = $false
#
#Label1
#
$Label1.BackColor = [System.Drawing.Color]::Transparent
$Label1.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]24,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$Label1.ForeColor = [System.Drawing.Color]::FromArgb(([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)))

$Label1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]26))
$Label1.Name = [System.String]'Label1'
$Label1.RightToLeft = [System.Windows.Forms.RightToLeft]::No
$Label1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]342,[System.Int32]57))
$Label1.TabIndex = [System.Int32]0
$Label1.Text = [System.String]'Aktualisierung'
$Label1.UseCompatibleTextRendering = $true
#
#Control3
#
$Control3.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]10,[System.Int32]10))
$Control3.Name = [System.String]'Control3'
$Control3.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]0,[System.Int32]0))
$Control3.TabIndex = [System.Int32]5
#
#Control4
#
$Control4.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]10,[System.Int32]10))
$Control4.Name = [System.String]'Control4'
$Control4.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]0,[System.Int32]0))
$Control4.TabIndex = [System.Int32]8
#
#ButtonSave
#
$ButtonSave.BackColor = [System.Drawing.Color]::White
$ButtonSave.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]449,[System.Int32]828))
$ButtonSave.Name = [System.String]'ButtonSave'
$ButtonSave.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]140,[System.Int32]60))
$ButtonSave.TabIndex = [System.Int32]9
$ButtonSave.Text = [System.String]'Save'
$ButtonSave.UseCompatibleTextRendering = $true
$ButtonSave.UseVisualStyleBackColor = $false
$ButtonSave.add_Click($ButtonSave_Click)
#
#ButtonCancel
#
$ButtonCancel.BackColor = [System.Drawing.Color]::White
$ButtonCancel.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$ButtonCancel.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Tahoma',[System.Single]8.25))
$ButtonCancel.ForeColor = [System.Drawing.Color]::FromArgb(([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)))

$ButtonCancel.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]595,[System.Int32]828))
$ButtonCancel.Name = [System.String]'ButtonCancel'
$ButtonCancel.RightToLeft = [System.Windows.Forms.RightToLeft]::No
$ButtonCancel.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]139,[System.Int32]60))
$ButtonCancel.TabIndex = [System.Int32]9
$ButtonCancel.Text = [System.String]'Cancel'
$ButtonCancel.UseCompatibleTextRendering = $true
$ButtonCancel.UseVisualStyleBackColor = $false
$ButtonCancel.add_Click($ButtonCancel_Click)
#
#Label8
#
$Label8.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]868))
$Label8.Name = [System.String]'Label8'
$Label8.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]177,[System.Int32]23))
$Label8.TabIndex = [System.Int32]10
$Label8.Text = [System.String] [char]0x00A9 +'Christian Schnagl | EDV-BV'
$Label8.UseCompatibleTextRendering = $true
$Label8.add_Click($Label8_Click)
#
#Control5
#
$Control5.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]10,[System.Int32]10))
$Control5.Name = [System.String]'Control5'
$Control5.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]0,[System.Int32]0))
$Control5.TabIndex = [System.Int32]11
#
#Label3
#
$Label3.BackColor = [System.Drawing.Color]::Transparent
$Label3.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]24,[System.Drawing.FontStyle]::Bold))
$Label3.ForeColor = [System.Drawing.Color]::FromArgb(([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)))

$Label3.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]14,[System.Int32]256))
$Label3.Name = [System.String]'Label3'
$Label3.RightToLeft = [System.Windows.Forms.RightToLeft]::No
$Label3.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]537,[System.Int32]66))
$Label3.TabIndex = [System.Int32]0
$Label3.Text = [System.String]'FirstRun - Config'
$Label3.UseCompatibleTextRendering = $true
#
#TableLayoutPanel1
#
$TableLayoutPanel1.ColumnCount = [System.Int32]2
$TableLayoutPanel1.ColumnStyles.Add((New-Object -TypeName System.Windows.Forms.ColumnStyle -ArgumentList @([System.Windows.Forms.SizeType]::Percent,[System.Single]50)))
$TableLayoutPanel1.ColumnStyles.Add((New-Object -TypeName System.Windows.Forms.ColumnStyle -ArgumentList @([System.Windows.Forms.SizeType]::Percent,[System.Single]50)))
$TableLayoutPanel1.Controls.Add($TextBoxOrgID,[System.Int32]1,[System.Int32]0)
$TableLayoutPanel1.Controls.Add($Label5,[System.Int32]0,[System.Int32]0)
$TableLayoutPanel1.Controls.Add($LabelWebhook,[System.Int32]0,[System.Int32]1)
$TableLayoutPanel1.Controls.Add($TextBoxWebhook,[System.Int32]1,[System.Int32]1)
$TableLayoutPanel1.Controls.Add($Label2,[System.Int32]0,[System.Int32]2)
$TableLayoutPanel1.Controls.Add($RichTextBoxCustomerInput,[System.Int32]1,[System.Int32]2)
$TableLayoutPanel1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]14,[System.Int32]430))
$TableLayoutPanel1.Name = [System.String]'TableLayoutPanel1'
$TableLayoutPanel1.RowCount = [System.Int32]3
$TableLayoutPanel1.RowStyles.Add((New-Object -TypeName System.Windows.Forms.RowStyle -ArgumentList @([System.Windows.Forms.SizeType]::Percent,[System.Single]20)))
$TableLayoutPanel1.RowStyles.Add((New-Object -TypeName System.Windows.Forms.RowStyle -ArgumentList @([System.Windows.Forms.SizeType]::Percent,[System.Single]20)))
$TableLayoutPanel1.RowStyles.Add((New-Object -TypeName System.Windows.Forms.RowStyle -ArgumentList @([System.Windows.Forms.SizeType]::Percent,[System.Single]60)))
$TableLayoutPanel1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]504,[System.Int32]177))
$TableLayoutPanel1.TabIndex = [System.Int32]12
$TableLayoutPanel1.add_Paint($TableLayoutPanel1_Paint)
#
#TextBoxOrgID
#
$TextBoxOrgID.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]255,[System.Int32]3))
$TextBoxOrgID.Name = [System.String]'TextBoxOrgID'
$TextBoxOrgID.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]246,[System.Int32]21))
$TextBoxOrgID.TabIndex = [System.Int32]13
#
#Label5
#
$Label5.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]12,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$Label5.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]0))
$Label5.Name = [System.String]'Label5'
$Label5.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]243,[System.Int32]39))
$Label5.TabIndex = [System.Int32]0
$Label5.Text = [System.String]'ITGLUE Organisation ID'
$Label5.UseCompatibleTextRendering = $true
#
#TextBoxWebhook
#
$TextBoxWebhook.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]255,[System.Int32]3))
$TextBoxWebhook.Name = [System.String]'TextBoxWebhook'
$TextBoxWebhook.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]246,[System.Int32]21))
$TextBoxWebhook.TabIndex = [System.Int32]13
#
#LabelWebhook
#
$LabelWebhook.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]12,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$LabelWebhook.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]0))
$LabelWebhook.Name = [System.String]'LabelWebhook'
$LabelWebhook.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]243,[System.Int32]39))
$LabelWebhook.TabIndex = [System.Int32]0
$LabelWebhook.Text = [System.String]'Webhook URL'
$LabelWebhook.UseCompatibleTextRendering = $true
#
#Label2
#
$Label2.BackColor = [System.Drawing.SystemColors]::ControlLightLight
$Label2.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]12,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$Label2.ForeColor = [System.Drawing.Color]::FromArgb(([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)))

$Label2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]39))
$Label2.Name = [System.String]'Label2'
$Label2.RightToLeft = [System.Windows.Forms.RightToLeft]::No
$Label2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]243,[System.Int32]54))
$Label2.TabIndex = [System.Int32]0
$Label2.Text = [System.String]'Bearbeiter - Firmen'
$Label2.UseCompatibleTextRendering = $true
#
#RichTextBoxCustomerInput
#
$RichTextBoxCustomerInput.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]255,[System.Int32]42))
$RichTextBoxCustomerInput.Name = [System.String]'RichTextBoxCustomerInput'
$RichTextBoxCustomerInput.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]246,[System.Int32]122))
$RichTextBoxCustomerInput.TabIndex = [System.Int32]14
$RichTextBoxCustomerInput.Text = [System.String]'EDV-BV'
#
#Label4
#
$Label4.BackColor = [System.Drawing.Color]::Transparent
$Label4.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]36,[System.Drawing.FontStyle]::Bold))
$Label4.ForeColor = [System.Drawing.Color]::FromArgb(([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)))

$Label4.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]10,[System.Int32]80))
$Label4.Name = [System.String]'Label4'
$Label4.RightToLeft = [System.Windows.Forms.RightToLeft]::No
$Label4.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]342,[System.Int32]66))
$Label4.TabIndex = [System.Int32]0
$Label4.Text = [System.String]'Masterimage'
$Label4.UseCompatibleTextRendering = $true
#
#Label6
#
$Label6.BackColor = [System.Drawing.Color]::Transparent
$Label6.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]15.75))
$Label6.ForeColor = [System.Drawing.Color]::FromArgb(([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)))

$Label6.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]20,[System.Int32]171))
$Label6.Name = [System.String]'Label6'
$Label6.RightToLeft = [System.Windows.Forms.RightToLeft]::No
$Label6.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]560,[System.Int32]95))
$Label6.TabIndex = [System.Int32]0
$Label6.Text = [System.String]'Automatische Dokumentation der Updates und Changes
an Masterimages der Firma EDV-BV'
$Label6.UseCompatibleTextRendering = $true
#
#Label9
#
$Label9.BackColor = [System.Drawing.SystemColors]::ControlLightLight
$Label9.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI Semilight',[System.Single]12))
$Label9.ForeColor = [System.Drawing.Color]::FromArgb(([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)))

$Label9.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]13,[System.Int32]99))
$Label9.Name = [System.String]'Label9'
$Label9.RightToLeft = [System.Windows.Forms.RightToLeft]::No
$Label9.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]243,[System.Int32]38))
$Label9.TabIndex = [System.Int32]0
$Label9.Text = [System.String]'ITGlueOrgID einfügen'
$Label9.UseCompatibleTextRendering = $true
#
#Label7
#
$Label7.BackColor = [System.Drawing.SystemColors]::ControlLightLight
$Label7.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI Semilight',[System.Single]12))
$Label7.ForeColor = [System.Drawing.Color]::FromArgb(([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)))

$Label7.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]13,[System.Int32]99))
$Label7.Name = [System.String]'Label7'
$Label7.RightToLeft = [System.Windows.Forms.RightToLeft]::No
$Label7.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]243,[System.Int32]38))
$Label7.TabIndex = [System.Int32]0
$Label7.Text = [System.String]'ITGlueOrgID einfügen'
$Label7.UseCompatibleTextRendering = $true
#
#FormFirstRun
#
$FormFirstRun.BackColor = [System.Drawing.SystemColors]::ControlLightLight
$FormFirstRun.CancelButton = $ButtonCancel
$FormFirstRun.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]746,[System.Int32]900))
$FormFirstRun.AutoScroll = $true
$FormFirstRun.Controls.Add($TableLayoutPanel1)
$FormFirstRun.Controls.Add($Label8)
$FormFirstRun.Controls.Add($ButtonSave)
$FormFirstRun.Controls.Add($PictureBoxFirstRun)
$FormFirstRun.Controls.Add($Control1)
$FormFirstRun.Controls.Add($Control2)
$FormFirstRun.Controls.Add($Label1)
$FormFirstRun.Controls.Add($Control3)
$FormFirstRun.Controls.Add($Control4)
$FormFirstRun.Controls.Add($ButtonCancel)
$FormFirstRun.Controls.Add($Control5)
$FormFirstRun.Controls.Add($Label3)
$FormFirstRun.Controls.Add($Label4)
$FormFirstRun.Controls.Add($Label6)
$FormFirstRun.Controls.Add($Label9)
$FormFirstRun.Controls.Add($Label7)
$FormFirstRun.Text = [System.String]'EDV-BV | Aktualisierung Masterimage'
$FormFirstRun.add_Load($Form1_Load)
([System.ComponentModel.ISupportInitialize]$PictureBoxFirstRun).EndInit()
$TableLayoutPanel1.ResumeLayout($false)
$TableLayoutPanel1.PerformLayout()
$FormFirstRun.ResumeLayout($false)
Add-Member -InputObject $FormFirstRun -Name base -Value $base -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name Control1 -Value $Control1 -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name Control2 -Value $Control2 -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name PictureBoxFirstRun -Value $PictureBoxFirstRun -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name Label1 -Value $Label1 -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name Control3 -Value $Control3 -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name Control4 -Value $Control4 -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name ButtonSave -Value $ButtonSave -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name ButtonCancel -Value $ButtonCancel -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name Label8 -Value $Label8 -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name Control5 -Value $Control5 -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name Label3 -Value $Label3 -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name TableLayoutPanel1 -Value $TableLayoutPanel1 -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name TextBoxOrgID -Value $TextBoxOrgID -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name TextBoxWebhook -Value $TextBoxWebhook -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name Label5 -Value $Label5 -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name LabelWebhook -Value $LabelWebhook -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name Label2 -Value $Label2 -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name RichTextBoxCustomerInput -Value $RichTextBoxCustomerInput -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name Label4 -Value $Label4 -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name Label6 -Value $Label6 -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name Label9 -Value $Label9 -MemberType NoteProperty
Add-Member -InputObject $FormFirstRun -Name Label7 -Value $Label7 -MemberType NoteProperty
}
. InitializeComponent
