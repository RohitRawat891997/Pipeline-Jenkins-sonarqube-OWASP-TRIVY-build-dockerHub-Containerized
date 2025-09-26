<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            Dashboard
        </h2>
    </x-slot>
 @foreach ($user as $user)
    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">

                    <div>
                        <h3>User Name :-{{ $user->name }}</h3>
                        <p>Created On: {{ \Carbon\Carbon::parse($user->created_at)->format('F d, Y') }}</p>
                    </div>

                </div>
            </div>
        </div>
        @endforeach
</x-app-layout>
