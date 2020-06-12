InModuleScope $env:BHProjectName {
    Describe "ReflectionCache" {
        Context "TypeAccelerators" {
            It "has typeaccelerators property" {
                # arrange

                # act
                $assert = [ReflectionCache] | Get-Member -Static | Where-Object { $_.Name -eq 'TypeAccelerators' }

                # assert
                $assert | Should -Not -BeNullOrEmpty
            }

            It "typeaccelerators property can register new type accelerators" {
                # arrange
                $typeAccelerators = [ReflectionCache]::TypeAccelerators

                # act
                $typeAccelerators::Add("TCP", "System.Net.Sockets.TCPClient")

                # assert
                $typeAccelerators::Get.GetEnumerator().Where( { $_.Key -like 'T*' } ) | Should -Not -BeNullOrEmpty
            }
        }
    }
}
