$FormA1 = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Label]$Aktualisierung = $null
[System.Windows.Forms.Control]$Control1 = $null
[System.Windows.Forms.Control]$Control2 = $null
[System.Windows.Forms.PictureBox]$PictureBox1 = $null
[System.Windows.Forms.Label]$LabelAktualisierung = $null
[System.Windows.Forms.Label]$LabelMasterimage = $null
[System.Windows.Forms.Control]$Control3 = $null
[System.Windows.Forms.TableLayoutPanel]$TableLayoutPanel1 = $null
[System.Windows.Forms.Label]$LabelFirma = $null
[System.Windows.Forms.TextBox]$TextBoxEditor = $null
[System.Windows.Forms.TextBox]$TextBoxConsultant = $null
[System.Windows.Forms.TextBox]$TextBoxTicket = $null
[System.Windows.Forms.TextBox]$TextBoxComment = $null
[System.Windows.Forms.ComboBox]$ComboBoxFirma = $null
[System.Windows.Forms.Label]$LabelBearbeiter = $null
[System.Windows.Forms.Label]$LabelBesprochen = $null
[System.Windows.Forms.Label]$LabelTicketnummer = $null
[System.Windows.Forms.Label]$LabelKommentar = $null
[System.Windows.Forms.TabControl]$TabControl = $null
[System.Windows.Forms.TabPage]$TabPageSoftware = $null
[System.Windows.Forms.DataGridView]$DataGridViewSoftware = $null
[System.Windows.Forms.TabPage]$TabPagePatches = $null
[System.Windows.Forms.DataGridView]$DataGridViewRegistry = $null
[System.Windows.Forms.TabPage]$TabPageRegistry = $null
[System.Windows.Forms.DataGridView]$DataGridViewPatches = $null
[System.Windows.Forms.Control]$Control4 = $null
[System.Windows.Forms.Button]$ButtonUpload = $null
[System.Windows.Forms.Button]$ButtonCancel = $null
[System.Windows.Forms.Label]$LabelCopyright = $null
[System.Windows.Forms.Control]$Control5 = $null
function InitializeComponent
{
$Aktualisierung = (New-Object -TypeName System.Windows.Forms.Label)
$Control1 = (New-Object -TypeName System.Windows.Forms.Control)
$Control2 = (New-Object -TypeName System.Windows.Forms.Control)
$PictureBox1 = (New-Object -TypeName System.Windows.Forms.PictureBox)
$LabelAktualisierung = (New-Object -TypeName System.Windows.Forms.Label)
$LabelMasterimage = (New-Object -TypeName System.Windows.Forms.Label)
$Control3 = (New-Object -TypeName System.Windows.Forms.Control)
$TableLayoutPanel1 = (New-Object -TypeName System.Windows.Forms.TableLayoutPanel)
$LabelFirma = (New-Object -TypeName System.Windows.Forms.Label)
$TextBoxEditor = (New-Object -TypeName System.Windows.Forms.TextBox)
$TextBoxConsultant = (New-Object -TypeName System.Windows.Forms.TextBox)
$TextBoxTicket = (New-Object -TypeName System.Windows.Forms.TextBox)
$TextBoxComment = (New-Object -TypeName System.Windows.Forms.TextBox)
$ComboBoxFirma = (New-Object -TypeName System.Windows.Forms.ComboBox)
$LabelBearbeiter = (New-Object -TypeName System.Windows.Forms.Label)
$LabelBesprochen = (New-Object -TypeName System.Windows.Forms.Label)
$LabelTicketnummer = (New-Object -TypeName System.Windows.Forms.Label)
$LabelKommentar = (New-Object -TypeName System.Windows.Forms.Label)
$TabControl = (New-Object -TypeName System.Windows.Forms.TabControl)
$TabPageSoftware = (New-Object -TypeName System.Windows.Forms.TabPage)
$TabPageRegistry = (New-Object -TypeName System.Windows.Forms.TabPage)
$Control4 = (New-Object -TypeName System.Windows.Forms.Control)
$ButtonUpload = (New-Object -TypeName System.Windows.Forms.Button)
$ButtonCancel = (New-Object -TypeName System.Windows.Forms.Button)
$LabelCopyright = (New-Object -TypeName System.Windows.Forms.Label)
$Control5 = (New-Object -TypeName System.Windows.Forms.Control)
$DataGridViewSoftware = (New-Object -TypeName System.Windows.Forms.DataGridView)
$DataGridViewPatches = (New-Object -TypeName System.Windows.Forms.DataGridView)
$TabPagePatches = (New-Object -TypeName System.Windows.Forms.TabPage)
$DataGridViewRegistry = (New-Object -TypeName System.Windows.Forms.DataGridView)
([System.ComponentModel.ISupportInitialize]$PictureBox1).BeginInit()
$TableLayoutPanel1.SuspendLayout()
$TabControl.SuspendLayout()
$TabPageSoftware.SuspendLayout()
$TabPageRegistry.SuspendLayout()
([System.ComponentModel.ISupportInitialize]$DataGridViewSoftware).BeginInit()
([System.ComponentModel.ISupportInitialize]$DataGridViewPatches).BeginInit()
$TabPagePatches.SuspendLayout()
([System.ComponentModel.ISupportInitialize]$DataGridViewRegistry).BeginInit()
$FormA1.SuspendLayout()
#
#Aktualisierung
#
$Aktualisierung.BackColor = [System.Drawing.Color]::Transparent
$Aktualisierung.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]15.75,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$Aktualisierung.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]10,[System.Int32]161))
$Aktualisierung.Name = [System.String]'Aktualisierung'
$Aktualisierung.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]560,[System.Int32]95))
$Aktualisierung.TabIndex = [System.Int32]0
$Aktualisierung.Text = [System.String]'Automatische Dokumentation der Updates und Changes
an Masterimages der Firma EDV-BV'
$Aktualisierung.UseCompatibleTextRendering = $true
$Aktualisierung.add_Click($LabelAktualisierung_Click)
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
#PictureBox1
#
$PictureBox1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]356,[System.Int32]26))
$PictureBox1.Name = [System.String]'PictureBox1'
$PictureBox1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]374,[System.Int32]120))
$PictureBox1.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::Zoom
$PictureBox1.TabIndex = [System.Int32]3
$PictureBox1.TabStop = $false
#
#LabelAktualisierung
#
$LabelAktualisierung.BackColor = [System.Drawing.Color]::Transparent
$LabelAktualisierung.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]24,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$LabelAktualisierung.ForeColor = [System.Drawing.Color]::FromArgb(([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)))

$LabelAktualisierung.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]14,[System.Int32]26))
$LabelAktualisierung.Name = [System.String]'LabelAktualisierung'
$LabelAktualisierung.RightToLeft = [System.Windows.Forms.RightToLeft]::No
$LabelAktualisierung.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]342,[System.Int32]57))
$LabelAktualisierung.TabIndex = [System.Int32]0
$LabelAktualisierung.Text = [System.String]'Aktualisierung'
$LabelAktualisierung.UseCompatibleTextRendering = $true
#
#LabelMasterimage
#
$LabelMasterimage.BackColor = [System.Drawing.Color]::Transparent
$LabelMasterimage.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]36,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$LabelMasterimage.ForeColor = [System.Drawing.Color]::FromArgb(([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)))

$LabelMasterimage.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]10,[System.Int32]80))
$LabelMasterimage.Name = [System.String]'LabelMasterimage'
$LabelMasterimage.RightToLeft = [System.Windows.Forms.RightToLeft]::No
$LabelMasterimage.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]342,[System.Int32]66))
$LabelMasterimage.TabIndex = [System.Int32]0
$LabelMasterimage.Text = [System.String]'Masterimage'
$LabelMasterimage.UseCompatibleTextRendering = $true
$LabelMasterimage.add_Click($LabelMasterimage_Click)
#
#Control3
#
$Control3.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]10,[System.Int32]10))
$Control3.Name = [System.String]'Control3'
$Control3.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]0,[System.Int32]0))
$Control3.TabIndex = [System.Int32]5
#
#TableLayoutPanel1
#
$TableLayoutPanel1.ColumnCount = [System.Int32]2
$TableLayoutPanel1.ColumnStyles.Add((New-Object -TypeName System.Windows.Forms.ColumnStyle -ArgumentList @([System.Windows.Forms.SizeType]::Percent,[System.Single]50)))
$TableLayoutPanel1.ColumnStyles.Add((New-Object -TypeName System.Windows.Forms.ColumnStyle -ArgumentList @([System.Windows.Forms.SizeType]::Percent,[System.Single]50)))
$TableLayoutPanel1.Controls.Add($LabelFirma,[System.Int32]0,[System.Int32]0)
$TableLayoutPanel1.Controls.Add($TextBoxEditor,[System.Int32]1,[System.Int32]1)
$TableLayoutPanel1.Controls.Add($TextBoxConsultant,[System.Int32]1,[System.Int32]2)
$TableLayoutPanel1.Controls.Add($TextBoxTicket,[System.Int32]1,[System.Int32]3)
$TableLayoutPanel1.Controls.Add($TextBoxComment,[System.Int32]1,[System.Int32]4)
$TableLayoutPanel1.Controls.Add($ComboBoxFirma,[System.Int32]1,[System.Int32]0)
$TableLayoutPanel1.Controls.Add($LabelBearbeiter,[System.Int32]0,[System.Int32]1)
$TableLayoutPanel1.Controls.Add($LabelBesprochen,[System.Int32]0,[System.Int32]2)
$TableLayoutPanel1.Controls.Add($LabelTicketnummer,[System.Int32]0,[System.Int32]3)
$TableLayoutPanel1.Controls.Add($LabelKommentar,[System.Int32]0,[System.Int32]4)
$TableLayoutPanel1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]10,[System.Int32]259))
$TableLayoutPanel1.Name = [System.String]'TableLayoutPanel1'
$TableLayoutPanel1.RowCount = [System.Int32]5
$TableLayoutPanel1.RowStyles.Add((New-Object -TypeName System.Windows.Forms.RowStyle -ArgumentList @([System.Windows.Forms.SizeType]::Absolute,[System.Single]30)))
$TableLayoutPanel1.RowStyles.Add((New-Object -TypeName System.Windows.Forms.RowStyle -ArgumentList @([System.Windows.Forms.SizeType]::Absolute,[System.Single]30)))
$TableLayoutPanel1.RowStyles.Add((New-Object -TypeName System.Windows.Forms.RowStyle -ArgumentList @([System.Windows.Forms.SizeType]::Absolute,[System.Single]30)))
$TableLayoutPanel1.RowStyles.Add((New-Object -TypeName System.Windows.Forms.RowStyle -ArgumentList @([System.Windows.Forms.SizeType]::Absolute,[System.Single]30)))
$TableLayoutPanel1.RowStyles.Add((New-Object -TypeName System.Windows.Forms.RowStyle -ArgumentList @([System.Windows.Forms.SizeType]::Absolute,[System.Single]30)))
$TableLayoutPanel1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]724,[System.Int32]164))
$TableLayoutPanel1.TabIndex = [System.Int32]6
$TableLayoutPanel1.add_Paint($TableLayoutPanel1_Paint)
#
#LabelFirma
#
$LabelFirma.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]15.75,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$LabelFirma.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]0))
$LabelFirma.Name = [System.String]'LabelFirma'
$LabelFirma.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]292,[System.Int32]30))
$LabelFirma.TabIndex = [System.Int32]0
$LabelFirma.Text = [System.String]'Firma'
$LabelFirma.UseCompatibleTextRendering = $true
#
#TextBoxEditor
#
$TextBoxEditor.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI Semilight',[System.Single]12,[System.Drawing.FontStyle]::Italic,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$TextBoxEditor.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]365,[System.Int32]33))
$TextBoxEditor.Name = [System.String]'TextBoxEditor'
$TextBoxEditor.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]353,[System.Int32]29))
$TextBoxEditor.TabIndex = [System.Int32]5
#
#TextBoxConsultant
#
$TextBoxConsultant.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI Semilight',[System.Single]12,[System.Drawing.FontStyle]::Italic,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$TextBoxConsultant.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]365,[System.Int32]63))
$TextBoxConsultant.Name = [System.String]'TextBoxConsultant'
$TextBoxConsultant.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]353,[System.Int32]29))
$TextBoxConsultant.TabIndex = [System.Int32]6
#
#TextBoxTicket
#
$TextBoxTicket.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI Semilight',[System.Single]12,[System.Drawing.FontStyle]::Italic,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$TextBoxTicket.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]365,[System.Int32]93))
$TextBoxTicket.Name = [System.String]'TextBoxTicket'
$TextBoxTicket.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]353,[System.Int32]29))
$TextBoxTicket.TabIndex = [System.Int32]7
#
#TextBoxComment
#
$TextBoxComment.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI Semilight',[System.Single]12,[System.Drawing.FontStyle]::Italic,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$TextBoxComment.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]365,[System.Int32]123))
$TextBoxComment.Name = [System.String]'TextBoxComment'
$TextBoxComment.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]353,[System.Int32]29))
$TextBoxComment.TabIndex = [System.Int32]8
#
#ComboBoxFirma
#
$ComboBoxFirma.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI Semilight',[System.Single]12,[System.Drawing.FontStyle]::Italic,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$ComboBoxFirma.FormattingEnabled = $true
$ComboBoxFirma.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]365,[System.Int32]3))
$ComboBoxFirma.Name = [System.String]'ComboBoxFirma'
$ComboBoxFirma.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]353,[System.Int32]29))
$ComboBoxFirma.TabIndex = [System.Int32]9
#
#LabelBearbeiter
#
$LabelBearbeiter.BackColor = [System.Drawing.Color]::Transparent
$LabelBearbeiter.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]15.75,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$LabelBearbeiter.ForeColor = [System.Drawing.Color]::FromArgb(([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)))

$LabelBearbeiter.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]30))
$LabelBearbeiter.Name = [System.String]'LabelBearbeiter'
$LabelBearbeiter.RightToLeft = [System.Windows.Forms.RightToLeft]::No
$LabelBearbeiter.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]292,[System.Int32]30))
$LabelBearbeiter.TabIndex = [System.Int32]0
$LabelBearbeiter.Text = [System.String]'Bearbeiter'
$LabelBearbeiter.UseCompatibleTextRendering = $true
#
#LabelBesprochen
#
$LabelBesprochen.BackColor = [System.Drawing.Color]::Transparent
$LabelBesprochen.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]15.75,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$LabelBesprochen.ForeColor = [System.Drawing.Color]::FromArgb(([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)))

$LabelBesprochen.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]60))
$LabelBesprochen.Name = [System.String]'LabelBesprochen'
$LabelBesprochen.RightToLeft = [System.Windows.Forms.RightToLeft]::No
$LabelBesprochen.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]292,[System.Int32]30))
$LabelBesprochen.TabIndex = [System.Int32]0
$LabelBesprochen.Text = [System.String]'Besprochen mit'
$LabelBesprochen.UseCompatibleTextRendering = $true
#
#LabelTicketnummer
#
$LabelTicketnummer.BackColor = [System.Drawing.Color]::Transparent
$LabelTicketnummer.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]15.75,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$LabelTicketnummer.ForeColor = [System.Drawing.Color]::FromArgb(([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)))

$LabelTicketnummer.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]90))
$LabelTicketnummer.Name = [System.String]'LabelTicketnummer'
$LabelTicketnummer.RightToLeft = [System.Windows.Forms.RightToLeft]::No
$LabelTicketnummer.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]292,[System.Int32]30))
$LabelTicketnummer.TabIndex = [System.Int32]0
$LabelTicketnummer.Text = [System.String]'Ticketnummer'
$LabelTicketnummer.UseCompatibleTextRendering = $true
#
#LabelKommentar
#
$LabelKommentar.BackColor = [System.Drawing.Color]::Transparent
$LabelKommentar.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]15.75,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$LabelKommentar.ForeColor = [System.Drawing.Color]::FromArgb(([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)))

$LabelKommentar.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]120))
$LabelKommentar.Name = [System.String]'LabelKommentar'
$LabelKommentar.RightToLeft = [System.Windows.Forms.RightToLeft]::No
$LabelKommentar.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]292,[System.Int32]44))
$LabelKommentar.TabIndex = [System.Int32]0
$LabelKommentar.Text = [System.String]'Kommentar'
$LabelKommentar.UseCompatibleTextRendering = $true
#
#TabControl
#
$TabControl.Controls.Add($TabPageSoftware)
$TabControl.Controls.Add($TabPagePatches)
$TabControl.Controls.Add($TabPageRegistry)
$TabControl.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]12,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$TabControl.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]10,[System.Int32]456))
$TabControl.Name = [System.String]'TabControl'
$TabControl.SelectedIndex = [System.Int32]0
$TabControl.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]724,[System.Int32]337))
$TabControl.TabIndex = [System.Int32]7
#
#TabPageSoftware
#
$TabPageSoftware.Controls.Add($DataGridViewSoftware)
$TabPageSoftware.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]14.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$TabPageSoftware.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]30))
$TabPageSoftware.Name = [System.String]'TabPageSoftware'
$TabPageSoftware.Padding = (New-Object -TypeName System.Windows.Forms.Padding -ArgumentList @([System.Int32]3))
$TabPageSoftware.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]716,[System.Int32]303))
$TabPageSoftware.TabIndex = [System.Int32]0
$TabPageSoftware.Text = [System.String]'Changes Software'
$TabPageSoftware.UseVisualStyleBackColor = $true
#
#TabPagePatches
#
$TabPagePatches.Controls.Add($DataGridViewPatches)
$TabPagePatches.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]30))
$TabPagePatches.Name = [System.String]'TabPagePatches'
$TabPagePatches.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]716,[System.Int32]303))
$TabPagePatches.TabIndex = [System.Int32]3
$TabPagePatches.Text = [System.String]'Changes Patches'
$TabPagePatches.UseVisualStyleBackColor = $true
#
#TabPageRegistry
#
$TabPageRegistry.Controls.Add($DataGridViewRegistry)
$TabPageRegistry.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]14.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$TabPageRegistry.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]30))
$TabPageRegistry.Name = [System.String]'TabPageRegistry'
$TabPageRegistry.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]716,[System.Int32]303))
$TabPageRegistry.TabIndex = [System.Int32]2
$TabPageRegistry.Text = [System.String]'Changes Registry'
$TabPageRegistry.UseVisualStyleBackColor = $true
#
#Control4
#
$Control4.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]10,[System.Int32]10))
$Control4.Name = [System.String]'Control4'
$Control4.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]0,[System.Int32]0))
$Control4.TabIndex = [System.Int32]8
#
#ButtonUpload
#
$ButtonUpload.BackColor = [System.Drawing.Color]::White
$ButtonUpload.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]449,[System.Int32]828))
$ButtonUpload.Name = [System.String]'ButtonUpload'
$ButtonUpload.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]140,[System.Int32]60))
$ButtonUpload.TabIndex = [System.Int32]9
$ButtonUpload.Text = [System.String]'Upload'
$ButtonUpload.UseCompatibleTextRendering = $true
$ButtonUpload.UseVisualStyleBackColor = $false
$ButtonUpload.add_Click($ButtonUpload_Click)
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
#LabelCopyright
#
$LabelCopyright.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]868))
$LabelCopyright.Name = [System.String]'LabelCopyright'
$LabelCopyright.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]177,[System.Int32]23))
$LabelCopyright.TabIndex = [System.Int32]10
$LabelCopyright.Text = [System.String] [char]0x00A9 +'Christian Schnagl | EDV-BV'
$LabelCopyright.UseCompatibleTextRendering = $true
$LabelCopyright.add_Click($LabelCopyright_Click)
#
#Control5
#
$Control5.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]10,[System.Int32]10))
$Control5.Name = [System.String]'Control5'
$Control5.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]0,[System.Int32]0))
$Control5.TabIndex = [System.Int32]11
#
#DataGridViewSoftware
#
$DataGridViewSoftware.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$DataGridViewSoftware.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]14.25))
$DataGridViewSoftware.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
$DataGridViewSoftware.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]-2,[System.Int32]0))
$DataGridViewSoftware.Name = [System.String]'DataGridViewSoftware'
$DataGridViewSoftware.RightToLeft = [System.Windows.Forms.RightToLeft]::No
$DataGridViewSoftware.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]722,[System.Int32]300))
$DataGridViewSoftware.TabIndex = [System.Int32]0
#
#DataGridViewPatches
#
$DataGridViewPatches.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$DataGridViewPatches.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]14.25))
$DataGridViewPatches.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
$DataGridViewPatches.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]-2,[System.Int32]0))
$DataGridViewPatches.Name = [System.String]'DataGridViewPatches'
$DataGridViewPatches.RightToLeft = [System.Windows.Forms.RightToLeft]::No
$DataGridViewPatches.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]722,[System.Int32]300))
$DataGridViewPatches.TabIndex = [System.Int32]0
#
#DataGridViewRegistry
#
$DataGridViewRegistry.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$DataGridViewRegistry.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Segoe UI',[System.Single]14.25))
$DataGridViewRegistry.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
$DataGridViewRegistry.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]-2,[System.Int32]0))
$DataGridViewRegistry.Name = [System.String]'DataGridViewRegistry'
$DataGridViewRegistry.RightToLeft = [System.Windows.Forms.RightToLeft]::No
$DataGridViewRegistry.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]722,[System.Int32]300))
$DataGridViewRegistry.TabIndex = [System.Int32]0
#
#FormA1
#
$FormA1.BackColor = [System.Drawing.SystemColors]::ControlLightLight
$FormA1.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]746,[System.Int32]900))
$FormA1.AutoScroll = $true
$FormA1.Controls.Add($LabelCopyright)
$FormA1.Controls.Add($ButtonUpload)
$FormA1.Controls.Add($TabControl)
$FormA1.Controls.Add($TableLayoutPanel1)
$FormA1.Controls.Add($PictureBox1)
$FormA1.Controls.Add($Aktualisierung)
$FormA1.Controls.Add($Control1)
$FormA1.Controls.Add($Control2)
$FormA1.Controls.Add($LabelAktualisierung)
$FormA1.Controls.Add($LabelMasterimage)
$FormA1.Controls.Add($Control3)
$FormA1.Controls.Add($Control4)
$FormA1.Controls.Add($ButtonCancel)
$FormA1.Controls.Add($Control5)
$FormA1.CancelButton = $ButtonCancel
$FormA1.Text = [System.String]'EDV-BV | Aktualisierung Masterimage'
$FormA1.add_Load($Form1_Load)
([System.ComponentModel.ISupportInitialize]$PictureBox1).EndInit()
$TableLayoutPanel1.ResumeLayout($false)
$TableLayoutPanel1.PerformLayout()
$TabControl.ResumeLayout($false)
$TabPageSoftware.ResumeLayout($false)
$TabPageRegistry.ResumeLayout($false)
([System.ComponentModel.ISupportInitialize]$DataGridViewSoftware).EndInit()
([System.ComponentModel.ISupportInitialize]$DataGridViewPatches).EndInit()
$TabPagePatches.ResumeLayout($false)
([System.ComponentModel.ISupportInitialize]$DataGridViewRegistry).EndInit()
$FormA1.ResumeLayout($false)
Add-Member -InputObject $FormA1 -Name base -Value $base -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name Aktualisierung -Value $Aktualisierung -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name Control1 -Value $Control1 -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name Control2 -Value $Control2 -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name PictureBox1 -Value $PictureBox1 -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name LabelAktualisierung -Value $LabelAktualisierung -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name LabelMasterimage -Value $LabelMasterimage -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name Control3 -Value $Control3 -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name TableLayoutPanel1 -Value $TableLayoutPanel1 -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name LabelFirma -Value $LabelFirma -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name TextBoxEditor -Value $TextBoxEditor -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name TextBoxConsultant -Value $TextBoxConsultant -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name TextBoxTicket -Value $TextBoxTicket -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name TextBoxComment -Value $TextBoxComment -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name ComboBoxFirma -Value $ComboBoxFirma -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name LabelBearbeiter -Value $LabelBearbeiter -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name LabelBesprochen -Value $LabelBesprochen -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name LabelTicketnummer -Value $LabelTicketnummer -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name LabelKommentar -Value $LabelKommentar -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name TabControl -Value $TabControl -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name TabPageSoftware -Value $TabPageSoftware -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name DataGridViewSoftware -Value $DataGridViewSoftware -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name TabPagePatches -Value $TabPagePatches -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name DataGridViewRegistry -Value $DataGridViewRegistry -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name TabPageRegistry -Value $TabPageRegistry -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name DataGridViewPatches -Value $DataGridViewPatches -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name Control4 -Value $Control4 -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name ButtonUpload -Value $ButtonUpload -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name ButtonCancel -Value $ButtonCancel -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name LabelCopyright -Value $LabelCopyright -MemberType NoteProperty
Add-Member -InputObject $FormA1 -Name Control5 -Value $Control5 -MemberType NoteProperty
}
. InitializeComponent
