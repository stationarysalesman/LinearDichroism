<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="17008000">
	<Item Name="My Computer" Type="My Computer">
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="AmplifierSim.lvclass" Type="LVClass" URL="../AmplifierSim.lvclass"/>
		<Item Name="MeasureDarkCurrent.vi" Type="VI" URL="../MeasureDarkCurrent.vi"/>
		<Item Name="MeasureDarkCurrentSimulation.vi" Type="VI" URL="../MeasureDarkCurrentSimulation.vi"/>
		<Item Name="MeasureDetectorVoltage.vi" Type="VI" URL="../MeasureDetectorVoltage.vi"/>
		<Item Name="MultimeterSim.lvclass" Type="LVClass" URL="../MultimeterSim.lvclass"/>
		<Item Name="SendRS232Command.vi" Type="VI" URL="../SendRS232Command.vi"/>
		<Item Name="Dependencies" Type="Dependencies">
			<Item Name="vi.lib" Type="Folder">
				<Item Name="Space Constant.vi" Type="VI" URL="/&lt;vilib&gt;/dlg_ctls.llb/Space Constant.vi"/>
			</Item>
		</Item>
		<Item Name="Build Specifications" Type="Build"/>
	</Item>
</Project>
